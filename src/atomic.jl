#
# Project : Camellia
# Source  : atomic.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/16
#

"""
    create_app_atomic(p_open::Ref{Bool})

Create an UI window for the atomic code, which is an atomic eigenvalue
problem solver in the iQIST package.
"""
function create_app_atomic(p_open::Ref{Bool})
    # Create the atomic window, which can not be resized.
    CImGui.Begin(
        "iQIST | atomic",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ATOMIC"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the solver.atomic.in
    _atomic_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _atomic_bottom_block(p_open)

    # End of this window
    CImGui.End()
end
