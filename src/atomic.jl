#
# Project : Camellia
# Source  : atomic.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/16
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
        # Input: Jp
        # Input: Ud
        # Input: Jh

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
