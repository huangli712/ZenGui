#
# Project : Camellia
# Source  : actest.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/09
#

"""
    create_app_actest(p_open::Ref{Bool})

Create an UI window for the ACTest toolkit, which is used to benchmark the
analytic continuation tools in the ACFlow package.
"""
function create_app_actest(p_open::Ref{Bool})
    # Create the ACTest window, which can not be resized.
    CImGui.Begin(
        "ACTest",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ACTEST"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For the [Test] block in the act.toml
    _actest_test_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the [Solver] block in the act.toml
    _actest_solver_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _actest_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _actest_test_block()

Setup widgets for the [Test] block in the act.toml.
"""
function _actest_test_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    CImGui.Text("Basic Configuration")

    # Input: solver
    CImGui.SetNextItemWidth(widget_combo_width)
    solver_list = ["MaxEnt", "BarRat", "NevanAC", "StochAC", "StochSK", "StochOM", "StochPX"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Analytic continuation solver", &id, solver_list)
        PTEST.solver = solver_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(solver)$(PTEST.solver)")
    #
    # Input: ptype
    CImGui.SetNextItemWidth(widget_combo_width)
    ptype_list = ["gauss", "lorentz", "delta", "rectangle", "risedecay"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Type of peaks in the spectrum", &id, ptype_list)
        PTEST.ptype = ptype_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ptype)$(PTEST.ptype)")
    #
    # Input: ktype
    CImGui.SetNextItemWidth(widget_combo_width)
    ktype_list = ["fermi", "boson", "bsymm"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Type of kernel function", &id, ktype_list)
        PTEST.ktype = ktype_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ktype)$(PTEST.ktype)")
    #
    # Input: grid
    CImGui.SetNextItemWidth(widget_combo_width)
    grid_list = ["ftime", "btime", "ffreq", "bfreq"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Grid for correlation function", &id, grid_list)
        PTEST.grid = grid_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(grid)$(PTEST.grid)")
    #
    # Input: mesh
    CImGui.SetNextItemWidth(widget_combo_width)
    mesh_list = ["linear", "tangent", "lorentz", "halflorentz"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Mesh for spectral function", &id, mesh_list)
        PTEST.mesh = mesh_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mesh)$(PTEST.mesh)")
    #
    # Input: ngrid
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _i = Cint(10) begin
        @c CImGui.InputInt(" Number of grid points", &_i)
        PTEST.ngrid = _i
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ngrid)$(PTEST.ngrid)")
    #
    # Input: nmesh
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _i = Cint(501) begin
        @c CImGui.InputInt(" Number of mesh points", &_i)
        PTEST.nmesh = _i
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nmesh)$(PTEST.nmesh)")
    #
    # Input: ntest
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _i = Cint(100) begin
        @c CImGui.InputInt(" Number of tests", &_i)
        PTEST.ntest = _i
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ntest)$(PTEST.ntest)")
    #
    # Input: wmax
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cdouble(5.0) begin
        @c CImGui.InputDouble(" Right boundary (maximum value) of real mesh", &_f)
        PTEST.wmax = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(wmax)$(PTEST.wmax)")
    #
    # Input: wmin
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cdouble(-5.0) begin
        @c CImGui.InputDouble(" Left boundary (minimum value) of real mesh", &_f)
        PTEST.wmin = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(wmin)$(PTEST.wmin)")
    #
    # Input: pmax
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cdouble(4.0) begin
        @c CImGui.InputDouble(" Right boundary (maximum value) for possible peaks", &_f)
        PTEST.pmax = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(pmax)$(PTEST.pmax)")
    #
    # Input: pmin
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cdouble(-4.0) begin
        @c CImGui.InputDouble(" Left boundary (minimum value) for possible peaks", &_f)
        PTEST.pmin = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(wmin)$(PTEST.pmin)")
    #
    # Input: beta
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cdouble(10.0) begin
        @c CImGui.InputDouble(" Inverse temperature", &_f)
        PTEST.beta = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(beta)$(PTEST.beta)")
    #
    # Input: noise
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cdouble(1.0e-6) begin
        @c CImGui.InputDouble(" Noise level", &_f)
        PTEST.noise = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(noise)$(PTEST.noise)")
    #
    # Input: offdiag
    CImGui.SetNextItemWidth(widget_combo_width)
    offdiag_list = ["Yes", "No"]
    @cstatic id = Cint(1) begin
        @c CImGui.Combo(" Is it the offdiagonal part in matrix-valued function", &id, offdiag_list)
        if id == 0
            PTEST.offdiag = true
        else
            PTEST.offdiag = false
        end
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(offdiag)$(PTEST.offdiag)")
    #
    # Input: lpeak
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic buf = "1,2,3" * "\0"^60 begin
        CImGui.InputText(" Number of peaks in the spectrum", buf, length(buf))
        buf = rstrip(buf,'\0')
        PTEST.lpeak = map(x -> parse(I64, x), split(buf, ","))
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lpeak)$(PTEST.lpeak)")
end

"""
    _actest_solver_block()

Setup widgets in the lower panel of the window for the ACTest toolkit.
"""
function _actest_solver_block()
    # It should change upon the selection of analytic continuation solver.
    CImGui.Text("Analytic Continuation Solver: $(PTEST.solver)")

    @cswitch PTEST.solver begin

        @case "MaxEnt"
            _acflow_maxent_block()
            break
        
        @case "BarRat"
            _acflow_barrat_block()
            break

        @case "NevanAC"
            _acflow_nevanac_block()
            break        
    
        @case "StochAC"
            _acflow_stochac_block()
            break

        @case "StochSK"
            _acflow_stochsk_block()
            break

        @case "StochOM"
            _acflow_stochom_block()
            break

        @case "StochPX"
            _acflow_stochpx_block()
            break
    
        @default
            sorry()
            break

    end
end

"""
    _actest_bottom_block(p_open::Ref{Bool})

Setup widgets in the bottom of the window for the ACTest toolkit.
"""
function _actest_bottom_block(p_open::Ref{Bool})
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
            text = _dict_to_toml(_build_actest_dict()) 
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
