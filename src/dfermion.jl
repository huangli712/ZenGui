#
# Project : Camellia
# Source  : dfermion.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/18
#

"""
    create_app_dfermion(p_open::Ref{Bool})

Create an UI window for the DFermion code, which is a dual fermion theory
engine.
"""
function create_app_dfermion(p_open::Ref{Bool})
    # Create the DFermion window, which can not be resized.
    CImGui.Begin(
        "DFermion",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "DFERMION"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # End of this window
    CImGui.End()
end
