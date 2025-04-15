#
# Project : Camellia
# Source  : ctseg.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/15
#

"""
    create_app_ctseg(p_open::Ref{Bool})

Create an UI window for the ctseg code, which is a continuous-time quantum
impurity solver in the iQIST package.
"""
function create_app_ctseg(p_open::Ref{Bool})
    # Create the ctseg window, which can not be resized.
    CImGui.Begin(
        "iQIST | ctseg",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "CTSEG"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the solver.ctqmc.in
    _ctseg_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _ctseg_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _ctseg_tabs_block()

Setup the tab widgets for all the blocks in the solver.ctqmc.in.
"""
function _ctseg_tabs_block()
    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    #
    if CImGui.BeginTabBar("ctsegTabBar", tab_bar_flags)
        _ctseg_model_block()
        _ctseg_dim_block()
        _ctseg_symm_block()
        _ctseg_repr_block()
        _ctseg_mc_block()
        _ctseg_meas_block()
        _ctseg_cycle_block()
        #
        CImGui.EndTabBar()
    end
end

"""
    _ctseg_bottom_block(p_open::Ref{Bool})

Setup widgets in the bottom of the window for the iQIST/ctseg code.
"""
function _ctseg_bottom_block(p_open::Ref{Bool})
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
            text = _dict_to_toml(_build_iqist_dict("ctseg"))
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
    _ctseg_model_block()
"""
function _ctseg_model_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("model")
        CImGui.Text("Configure [model] Part")

        # Input: isscr
        CImGui.SetNextItemWidth(widget_combo_width)
        isscr_list = ["static", "plasmon pole", "ohmic", "realistic"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" ", &id, isscr_list)
            PCTSEG.isscr = id + 1
            id != 0 && push!(_CTSEG, "isscr")
            id == 0 && delete!(_CTSEG, "isscr")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(isscr)$(PCTSEG.isscr)")
        #
        # Input: nband
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(1) begin
            @c CImGui.SliderInt(" Number of correlated bands", &_i, 1, 7)
            PCTSEG.nband = _i
            _i != 1 && push!(_CTSEG, "nband")
            _i == 1 && delete!(_CTSEG, "nband")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nband)$(PCTSEG.nband)")
        #
        # Input: nspin
        # Input: norbs
        # Input: ncfgs
        # Input: Uc
        # Input: Jz
        # Input: lc
        # Input: wc
        # Input: mune
        # Input: beta
        # Input: part

        CImGui.EndTabItem()
    end
end

"""
    _ctseg_dim_block()
"""
function _ctseg_dim_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("dimension")
        CImGui.Text("Configure [dimension] Part")

        CImGui.EndTabItem()
    end
end

"""
    _ctseg_symm_block()
"""
function _ctseg_symm_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("symmetry")
        CImGui.Text("Configure [symmetry] Part")

        CImGui.EndTabItem()
    end
end

"""
    _ctseg_repr_block()
"""
function _ctseg_repr_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("representation")
        CImGui.Text("Configure [representation] Part")

        CImGui.EndTabItem()
    end
end

"""
    _ctseg_mc_block()
"""
function _ctseg_mc_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("monte carlo")
        CImGui.Text("Configure [monte carlo] Part")

        CImGui.EndTabItem()
    end
end

"""
    _ctseg_meas_block()
"""
function _ctseg_meas_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("measure")
        CImGui.Text("Configure [measure] Part")

        CImGui.EndTabItem()
    end
end

"""
    _ctseg_cycle_block()
"""
function _ctseg_cycle_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("cycle")
        CImGui.Text("Configure [cycle] Part")

        # Input: isscf
        CImGui.SetNextItemWidth(widget_combo_width)
        isscf_list = ["1:one-shot", "2:self-consistent"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Scheme of dynamical mean-field theory calculations", &id, isscf_list)
            PCTSEG.isscf = id + 1
            id != 0 && push!(_CTSEG, "isscf")
            id == 0 && delete!(_CTSEG, "isscf")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(isscf)$(PCTSEG.isscf)")
        #
        # Input: niter
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(20) begin
            @c CImGui.SliderInt(" Number of self-consistent iterations", &_i, 1, 100)
            PCTSEG.niter = _i
            _i != 20 && push!(_CTSEG, "niter")
            _i == 20 && delete!(_CTSEG, "niter")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(niter)$(PCTSEG.niter)")
        #
        # Input: alpha
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.7) vmin = Cdouble(0.0) vmax = Cdouble(1.0) begin
            @c CImGui.SliderScalar(
                " Mixing factor for self-consistent engine",
                CImGui.ImGuiDataType_Double,
                &_f,
                &vmin, &vmax
            )
            PCTSEG.alpha = _f
            _f != 0.7 && push!(_CTSEG, "alpha")
            _f == 0.7 && delete!(_CTSEG, "alpha")
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(alpha)$(PCTSEG.alpha)")

        CImGui.EndTabItem()
    end
end
