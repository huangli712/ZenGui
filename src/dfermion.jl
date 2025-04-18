#
# Project : Camellia
# Source  : dfermion.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/18
#

"""
    create_app_dfermion(p_open::Ref{Bool})

Create an UI window for the DFermion code, which is a dual fermion theory
engine.
"""
function create_app_dfermion(p_open::Ref{Bool})
    # Create the DFermion window, which can not be resized.
    CImGui.Begin(
        "DFermion",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "DFERMION"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the dfa.in
    _dfermion_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _dfermion_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _dfermion_tabs_block()

Setup the tab widgets for all the blocks in the dfa.in.
"""
function _dfermion_tabs_block()
    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    #
    if CImGui.BeginTabBar("dfermionTabBar", tab_bar_flags)
        _dfermion_model_block()
        _dfermion_dim_block()
        _dfermion_kmesh_block()
        _dfermion_cycle_block()
        #
        CImGui.EndTabBar()
    end
end

"""
    _dfermion_bottom_block(p_open::Ref{Bool})

Setup widgets in the bottom of the window for the DFermion code.
"""
function _dfermion_bottom_block(p_open::Ref{Bool})
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
            text = _dict_to_string(_build_dfermion_dict())
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
    _dfermion_model_block()
"""
function _dfermion_model_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("model")
        CImGui.Text("Configure [model] Part")

        # Input: nband
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(1) begin
            @c CImGui.SliderInt(" Number of correlated bands", &_i, 1, 7)
            PDFERMION.nband = _i
            _i != 1 && push!(_DFERMION, "nband")
            _i == 1 && delete!(_DFERMION, "nband")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nband)$(PDFERMION.nband)")
        #
        # Input: nspin
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(2) begin
            @c CImGui.InputInt(" Number of spin projections", &_i)
            _i = Cint(PDFERMION.nspin) # This parameter should not be changed.
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nspin)$(PDFERMION.nspin)")
        #
        # Input: norbs
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(2) begin
            @c CImGui.InputInt(" Number of correlated orbitals", &_i)
            _i = Cint(PDFERMION.nspin * PDFERMION.nband)
            PDFERMION.norbs = _i
            _i != 2 && push!(_DFERMION, "norbs")
            _i == 2 && delete!(_DFERMION, "norbs")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(norbs)$(PDFERMION.norbs)")
        #
        # Input: mune
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0) begin
            @c CImGui.InputDouble(" Chemical potential or fermi level", &_f)
            PDFERMION.mune = _f
            _f != 0.0 && push!(_DFERMION, "mune")
            _f == 0.0 && delete!(_DFERMION, "mune")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mune)$(PDFERMION.mune)")
        #
        # Input: beta
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(1.0) begin
            @c CImGui.InputDouble(" Inversion of temperature", &_f)
            PDFERMION.beta = _f
            _f != 1.0 && push!(_DFERMION, "beta")
            _f == 1.0 && delete!(_DFERMION, "beta")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(beta)$(PDFERMION.beta)")
        #
        # Input: part
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(1.0) begin
            @c CImGui.InputDouble(" Hopping parameter t for Hubbard model", &_f)
            PDFERMION.part = _f
            _f != 1.0 && push!(_DFERMION, "part")
            _f == 1.0 && delete!(_DFERMION, "part")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(part)$(PDFERMION.part)")

        CImGui.EndTabItem()
    end
end

"""
    _dfermion_dim_block()
"""
function _dfermion_dim_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("dimension")
        CImGui.Text("Configure [dimension] Part")

        # Input: nffrq
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(16) begin
            @c CImGui.SliderInt(" Number of fermionic frequencies for 2P function", &_i, 8, 1024)
            PDFERMION.nffrq = _i
            _i != 16 && push!(_DFERMION, "nffrq")
            _i == 16 && delete!(_DFERMION, "nffrq")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nffrq)$(PDFERMION.nffrq)")
        #
        # Input: nbfrq
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(7) begin
            @c CImGui.SliderInt(" Number of bosonic frequncies for 2P function", &_i, 4, 512)
            PDFERMION.nbfrq = _i
            _i != 7 && push!(_DFERMION, "nbfrq")
            _i == 7 && delete!(_DFERMION, "nbfrq")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nbfrq)$(PDFERMION.nbfrq)")

        CImGui.EndTabItem()
    end
end

"""
    _dfermion_kmesh_block()
"""
function _dfermion_kmesh_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("k-mesh")
        CImGui.Text("Configure [k-mesh] Part")

        # Input: nkpts
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(64) begin
            @c CImGui.InputInt(" Number of k-points (totally)", &_i)
            PDFERMION.nkpts = _i
            _i != 64 && push!(_DFERMION, "nkpts")
            _i == 64 && delete!(_DFERMION, "nkpts")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nkpts)$(PDFERMION.nkpts)")
        #
        # Input: nkp_x
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(8) begin
            @c CImGui.InputInt(" Number of k-points (along x-axis)", &_i)
            PDFERMION.nkp_x = _i
            _i != 8 && push!(_DFERMION, "nkp_x")
            _i == 8 && delete!(_DFERMION, "nkp_x")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nkp_x)$(PDFERMION.nkp_x)")

        CImGui.EndTabItem()
    end
end

"""
    _dfermion_cycle_block()
"""
function _dfermion_cycle_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("cycle")
        CImGui.Text("Configure [cycle] Part")

        CImGui.EndTabItem()
    end
end
