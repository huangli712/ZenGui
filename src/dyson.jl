#
# Project : Camellia
# Source  : dyson.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
#

function create_app_dyson(p_open::Ref{Bool})
    # Create the Dyson window, which is modal and can not be resized.
    CImGui.Begin(
        "Dyson",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    if CImGui.IsWindowFocused()
        CWIN.name = "DYSON"
    end

    # Fix size of the window
    window_width = 400.0
    window_height = 300.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    CImGui.Text("Dyson")

    # End of this window
    CImGui.End()
end
