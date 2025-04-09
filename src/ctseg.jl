#
# Project : Camellia
# Source  : ctseg.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/09
#

"""
    create_app_ctseg(p_open::Ref{Bool})

Create an UI window for the ctseg code, which is a continuous-time quantum
impurity solver in the iQIST package.
"""
function create_app_ctseg(p_open::Ref{Bool})
    # Create the ctseg window, which is modal and can not be resized.
    CImGui.Begin(
        "iQIST | CTSEG",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "CTSEG"
    end

    # Fix size of the window
    window_width = 400.0
    window_height = 300.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    CImGui.Text("CTSEG")

    # End of this window
    CImGui.End()
end
