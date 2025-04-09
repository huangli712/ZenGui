#
# Project : Camellia
# Source  : atomic.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/09
#

"""
    create_app_atomic(p_open::Ref{Bool})

Create an UI window for the atomic code, which is an atomic eigenvalue
problem solver in the iQIST package.
"""
function create_app_atomic(p_open::Ref{Bool})
    # Create the atomic window, which is modal and can not be resized.
    CImGui.Begin(
        "iQIST | ATOMIC",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ATOMIC"
    end

    # Fix size of the window
    window_width = 400.0
    window_height = 300.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    CImGui.Text("ATOMIC")

    # End of this window
    CImGui.End()
end
