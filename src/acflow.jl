#
# Project : Camellia
# Source  : acflow.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/06
#

"""
    create_app_acflow(p_open::Ref{Bool})

Create an UI window for the ACFlow toolkit.
"""
function create_app_acflow(p_open::Ref{Bool})
    # Create the ACFlow window, which can not be resized.
    CImGui.Begin(
        "ACFlow",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    # Below the widgets are placed one by one.

    # Input: finput
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.InputText(" Filename for input data", PBASE.finput, length(PBASE.finput))
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(finput)$(PBASE.finput)")
    #
    # Input: solver
    CImGui.SetNextItemWidth(widget_combo_width)
    solver_list = ["MaxEnt", "BarRat", "NevanAC", "StochAC", "StochSK", "StochOM", "StochPX"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Solver for the analytic continuation problem", &id, solver_list)
        PBASE.solver = solver_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(solver)$(PBASE.solver)")
    #
    # Input: ktype
    CImGui.SetNextItemWidth(widget_combo_width)
    ktype_list = ["fermi", "boson", "bsymm"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Type of kernel function", &id, ktype_list)
        PBASE.ktype = ktype_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ktype)$(PBASE.ktype)")
    #
    # Input: mtype
    CImGui.SetNextItemWidth(widget_combo_width)
    mtype_list = ["flat", "gauss", "1gauss", "2gauss", "lorentz", "1lorentz", "2lorentz", "risedecay", "file"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Type of default model function", &id, mtype_list)
        PBASE.mtype = mtype_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mtype)$(PBASE.mtype)")
    #
    # Input: grid
    CImGui.SetNextItemWidth(widget_combo_width)
    grid_list = ["ftime", "fpart", "btime", "bpart", "ffreq", "ffrag", "bfreq", "bfrag"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Grid for input data (imaginary axis)", &id, grid_list)
        PBASE.grid = grid_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(grid)$(PBASE.grid)")
    #
    # Input: mesh
    CImGui.SetNextItemWidth(widget_combo_width)
    mesh_list = ["linear", "tangent", "lorentz", "halflorentz"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Mesh for output data (real axis)", &id, mesh_list)
        PBASE.mesh = mesh_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mesh)$(PBASE.mesh)")
    #
    # Input: ngrid
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _i = Cint(10) begin
        @c CImGui.InputInt(" Number of grid points", &_i)
        PBASE.ngrid = _i
    end    
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ngrid)$(PBASE.ngrid)")
    #
    # Input: nmesh
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _i = Cint(501) begin
        @c CImGui.InputInt(" Number of mesh points", &_i)
        PBASE.nmesh = _i
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nmesh)$(PBASE.nmesh)")
    #
    # Input: wmax
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cfloat(5.0) begin
        @c CImGui.InputFloat(" Right boundary (maximum value) of output mesh", &_f)
        PBASE.wmax = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(wmax)$(PBASE.wmax)")
    #
    # Input: wmin
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cfloat(-5.0) begin
        @c CImGui.InputFloat(" Left boundary (minimum value) of output mesh", &_f)
        PBASE.wmin = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(wmin)$(PBASE.wmin)")
    #
    # Input: beta
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic _f = Cfloat(10.0) begin
        @c CImGui.InputFloat(" Inverse temperature", &_f)
        PBASE.beta = _f
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(beta)$(PBASE.beta)")

    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "offdiag:")
    CImGui.SameLine()
    CImGui.Text("Is it the offdiagonal part in matrix-valued function")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "fwrite :")
    CImGui.SameLine()
    CImGui.Text("Are the analytic continuation results written into files")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Dummy(ImVec2(0.0,10.0))

    button_width = 80.0
    button_height = 25.0
    if CImGui.Button("Generate", ImVec2(button_width, button_height))
        @show PBASE
    end

    # End of this window
    CImGui.End()
end
