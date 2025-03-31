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
    window_width = 500.0
    window_height = 800.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    CImGui.Text("Filename for input data")
    CImGui.Text("Solver for the analytic continuation problem")
    CImGui.Text("Type of kernel function")
    CImGui.Text("Type of default model function")
    CImGui.Text("Grid for input data (imaginary axis)")
    CImGui.Text("Mesh for output data (real axis)")
    CImGui.Text("Number of grid points")
    CImGui.Text("Number of mesh points")
    CImGui.Text("Right boundary (maximum value) of output mesh")
    CImGui.Text("Left boundary (minimum value) of output mesh")
    CImGui.Text("Inverse temperature")
    CImGui.Text("Is it the offdiagonal part in matrix-valued function")
    CImGui.Text("Are the analytic continuation results written into files")
    CImGui.Text("")
    CImGui.Text("")
    CImGui.Text("")

    # End of this window
    CImGui.End()
end
