#
# Project : Camellia
# Source  : atomic.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/17
#

"""
    create_app_atomic(p_open::Ref{Bool})

Create an UI window for the atomic code, which is an atomic eigenvalue
problem solver in the iQIST package.
"""
function create_app_atomic(p_open::Ref{Bool})
    # Create the atomic window, which can not be resized.
    CImGui.Begin(
        "iQIST | atomic",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ATOMIC"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the solver.atomic.in
    _atomic_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _atomic_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _atomic_tabs_block()

Setup the tab widgets for all the blocks in the solver.atomic.in.
"""
function _atomic_tabs_block()
    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    #
    if CImGui.BeginTabBar("atomicTabBar", tab_bar_flags)
        _atomic_model_block()
        _atomic_interaction_block()
        _atomic_natural_block()
        _atomic_algorithm_block()
        #
        CImGui.EndTabBar()
    end
end

"""
    _atomic_bottom_block(p_open::Ref{Bool})

Setup widgets in the bottom of the window for the iQIST/atomic code.
"""
function _atomic_bottom_block(p_open::Ref{Bool})
    # Define the default size for widgets
    widget_button_width = 80.0
    widget_button_height = 25.0

    # For the buttons
    if CImGui.Button("View", ImVec2(widget_button_width, widget_button_height))
        CImGui.OpenPopup("View")
    end
    #
    if CImGui.BeginPopupModal("View", C_NULL, CImGui.ImGuiWindowFlags_AlwaysAutoResize)
        @cstatic read_only=false text="Hello World!" begin
            text = _dict_to_toml(_build_iqist_dict("atomic"))
            @c CImGui.Checkbox("Read-only", &read_only)
            flags = read_only ? CImGui.ImGuiInputTextFlags_ReadOnly : 0
            flags = CImGui.ImGuiInputTextFlags_AllowTabInput | flags
            CImGui.InputTextMultiline("##source", text, 10000, ImVec2(400, 600), flags)
        end
        #
        if CImGui.Button("OK", ImVec2(widget_button_width, widget_button_height))
            CImGui.CloseCurrentPopup()
        end
        #
        CImGui.EndPopup()
    end
    #
    CImGui.SameLine()
    #
    if CImGui.Button("Close", ImVec2(widget_button_width, widget_button_height))
        p_open[] = false
    end
end

"""
    _atomic_model_block()
"""
function _atomic_model_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("model")
        CImGui.Text("Configure [model] Part")

        # Input: nband
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(1) begin
            @c CImGui.SliderInt(" Number of correlated bands", &_i, 1, 7)
            PATOMIC.nband = _i
            _i != 1 && push!(_ATOMIC, "nband")
            _i == 1 && delete!(_ATOMIC, "nband")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nband)$(PATOMIC.nband)")
        #
        # Input: nspin
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(2) begin
            @c CImGui.InputInt(" Number of spin projections", &_i)
            _i = Cint(PATOMIC.nspin) # This parameter should not be changed.
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nspin)$(PATOMIC.nspin)")
        #
        # Input: norbs
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(2) begin
            @c CImGui.InputInt(" Number of correlated orbitals", &_i)
            _i = Cint(PATOMIC.nspin * PATOMIC.nband)
            PATOMIC.norbs = _i
            _i != 2 && push!(_ATOMIC, "norbs")
            _i == 2 && delete!(_ATOMIC, "norbs")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(norbs)$(PATOMIC.norbs)")
        #
        # Input: ncfgs
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(4) begin
            @c CImGui.InputInt(" Number of many-body configurations", &_i)
            _i = Cint(2 ^ PATOMIC.norbs)
            PATOMIC.ncfgs = _i
            _i != 4 && push!(_ATOMIC, "ncfgs")
            _i == 4 && delete!(_ATOMIC, "ncfgs")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ncfgs)$(PATOMIC.ncfgs)")

        CImGui.EndTabItem()
    end
end

"""
    _atomic_interaction_block()
"""
function _atomic_interaction_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("interaction")
        CImGui.Text("Configure [interaction] Part")

        # Input: icu
        CImGui.SetNextItemWidth(widget_combo_width)
        icu_list = ["kanamori", "slater-cordon"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Type of Coulomb interaction matrix", &id, icu_list)
            PATOMIC.icu = id + 1
            id != 0 && push!(_ATOMIC, "icu")
            id == 0 && delete!(_ATOMIC, "icu")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(icu)$(PATOMIC.icu)")
        #
        # Input: Uc
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(2.0) begin
            @c CImGui.InputDouble(" Intra-orbital Coulomb interaction", &_f)
            PATOMIC.Uc = _f
            _f != 2.0 && push!(_ATOMIC, "Uc")
            _f == 2.0 && delete!(_ATOMIC, "Uc")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Uc)$(PATOMIC.Uc)")
        #
        # Input: Uv
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(2.0) begin
            @c CImGui.InputDouble(" Inter-orbital Coulomb interaction", &_f)
            PATOMIC.Uv = _f
            _f != 2.0 && push!(_ATOMIC, "Uv")
            _f == 2.0 && delete!(_ATOMIC, "Uv")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Uv)$(PATOMIC.Uv)")
        #
        # Input: Jz
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Hund's exchange interaction in z axis", &_f)
            PATOMIC.Jz = _f
            _f != 0.0 && push!(_ATOMIC, "Jz")
            _f == 0.0 && delete!(_ATOMIC, "Jz")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Jz)$(PATOMIC.Jz)")
        #
        # Input: Js
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Spin-flip interaction", &_f)
            PATOMIC.Js = _f
            _f != 0.0 && push!(_ATOMIC, "Js")
            _f == 0.0 && delete!(_ATOMIC, "Js")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Js)$(PATOMIC.Js)")
        #
        # Input: Jp
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Pair-hopping interaction", &_f)
            PATOMIC.Jp = _f
            _f != 0.0 && push!(_ATOMIC, "Jp")
            _f == 0.0 && delete!(_ATOMIC, "Jp")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Jp)$(PATOMIC.Jp)")
        #
        # Input: Ud
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(2.0) begin
            @c CImGui.InputDouble(" Coulomb interaction parameter (Slater type)", &_f)
            PATOMIC.Ud = _f
            _f != 2.0 && push!(_ATOMIC, "Ud")
            _f == 2.0 && delete!(_ATOMIC, "Ud")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Ud)$(PATOMIC.Ud)")
        #
        # Input: Jh
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Hund's exchange parameter (Slater type)", &_f)
            PATOMIC.Jh = _f
            _f != 0.0 && push!(_ATOMIC, "Jh")
            _f == 0.0 && delete!(_ATOMIC, "Jh")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(Jh)$(PATOMIC.Jh)")

        CImGui.EndTabItem()
    end
end

"""
    _atomic_natural_block()
"""
function _atomic_natural_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("natural eigenbasis")
        CImGui.Text("Configure [natural eigenbasis] Part")

        # Input: ibasis
        CImGui.SetNextItemWidth(widget_combo_width)
        ibasis_list = ["builtin", "external"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" How to build the natural eigenbasis", &id, ibasis_list)
            PATOMIC.ibasis = id + 1
            id != 0 && push!(_ATOMIC, "ibasis")
            id == 0 && delete!(_ATOMIC, "ibasis")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ibasis)$(PATOMIC.ibasis)")
        #
        # Input: icf
        CImGui.SetNextItemWidth(widget_combo_width)
        icf_list = ["none", "diagonal", "off-diagonal"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Type of crystal field splitting", &id, icf_list)
            PATOMIC.icf = id
            id != 0 && push!(_ATOMIC, "icf")
            id == 0 && delete!(_ATOMIC, "icf")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(icf)$(PATOMIC.icf)")
        #
        # Input: isoc
        CImGui.SetNextItemWidth(widget_combo_width)
        isoc_list = ["none", "onsite"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Type of spin-orbit coupling", &id, isoc_list)
            PATOMIC.isoc = id
            id != 0 && push!(_ATOMIC, "isoc")
            id == 0 && delete!(_ATOMIC, "isoc")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(isoc)$(PATOMIC.isoc)")
        #
        # Input: mune
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Chemical potential or fermi level", &_f)
            PATOMIC.mune = _f
            _f != 0.0 && push!(_ATOMIC, "mune")
            _f == 0.0 && delete!(_ATOMIC, "mune")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mune)$(PATOMIC.mune)")
        #
        # Input: lambda
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Strength of spin-orbit coupling", &_f)
            PATOMIC.lambda = _f
            _f != 0.0 && push!(_ATOMIC, "lambda")
            _f == 0.0 && delete!(_ATOMIC, "lambda")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lambda)$(PATOMIC.lambda)")

        CImGui.EndTabItem()
    end
end

"""
    _atomic_algorithm_block()
"""
function _atomic_algorithm_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("algorithm")
        CImGui.Text("Configure [algorithm] Part")

        CImGui.EndTabItem()
    end
end
