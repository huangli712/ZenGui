#
# Project : Camellia
# Source  : cthyb.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
#

function create_app_cthyb(p_open::Ref{Bool})
    # Create the CTHYB window, which is modal and can not be resized.
    CImGui.Begin(
        "iQIST | CTHYB",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    if CImGui.IsWindowFocused()
        CWIN.name = "CTHYB"
    end

    # Fix size of the window
    window_width = 400.0
    window_height = 300.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    CImGui.Text("CTHYB")

    # End of this window
    CImGui.End()
end
