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


    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Filename for input data")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Solver for the analytic continuation problem")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Type of kernel function")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Type of default model function")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Grid for input data (imaginary axis)")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Mesh for output data (real axis)")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Number of grid points")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Number of mesh points")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Right boundary (maximum value) of output mesh")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Left boundary (minimum value) of output mesh")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Inverse temperature")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Is it the offdiagonal part in matrix-valued function")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "License:")
    CImGui.SameLine()
    CImGui.Text("Are the analytic continuation results written into files")

    # End of this window
    CImGui.End()
end
