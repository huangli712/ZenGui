#
# Project : Camellia
# Source  : acflow.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/31
#

function create_app_acflow(p_open::Ref{Bool})
    # Create the about window, which is modal and can not be resized.
    CImGui.Begin(
        "ACFlow",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    # End of this window
    CImGui.End()
end