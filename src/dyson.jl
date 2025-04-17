#
# Project : Camellia
# Source  : dyson.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/17
#

"""
    create_app_dyson(p_open::Ref{Bool})

Create an UI window for the Dyson code, which is a dynamical mean-field
theory engine.
"""
function create_app_dyson(p_open::Ref{Bool})
    # Create the Dyson window, which can not be resized.
    CImGui.Begin(
        "Dyson",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "DYSON"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the dmft.in
    _dyson_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _dyson_bottom_block(p_open)

    # End of this window
    CImGui.End()
end
