#
# Project : Camellia
# Source  : acflow.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/31
#

function create_app_acflow(p_open::Ref{Bool})
    # Create the ACFlow window, which is modal and can not be resized.
    CImGui.Begin(
        "ACFlow",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    widget_input_width = 100
    widget_combo_width = 100

    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "finput :")
    CImGui.SameLine()
    CImGui.Text("Filename for input data")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    @cstatic finput = "giw.data" begin
        CImGui.InputText("T1", finput, length(finput) * 2)
    end
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "solver :")
    CImGui.SameLine()
    CImGui.Text("Solver for the analytic continuation problem")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_combo_width)
    solvers = ["MaxEnt", "BarRat", "NevanAC", "StochAC", "StochSK", "StochOM", "StochPX"]
    @cstatic solver_id = Cint(0) begin
        @c CImGui.Combo("C1", &solver_id, solvers)
    end
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "ktype  :")
    CImGui.SameLine()
    CImGui.Text("Type of kernel function")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "mtype  :")
    CImGui.SameLine()
    CImGui.Text("Type of default model function")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "grid   :")
    CImGui.SameLine()
    CImGui.Text("Grid for input data (imaginary axis)")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "mesh   :")
    CImGui.SameLine()
    CImGui.Text("Mesh for output data (real axis)")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "ngrid  :")
    CImGui.SameLine()
    CImGui.Text("Number of grid points")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "nmesh  :")
    CImGui.SameLine()
    CImGui.Text("Number of mesh points")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "wmax   :")
    CImGui.SameLine()
    CImGui.Text("Right boundary (maximum value) of output mesh")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "wmin   :")
    CImGui.SameLine()
    CImGui.Text("Left boundary (minimum value) of output mesh")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "beta   :")
    CImGui.SameLine()
    CImGui.Text("Inverse temperature")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
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

    # End of this window
    CImGui.End()
end
