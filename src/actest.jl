#
# Project : Camellia
# Source  : actest.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/09
#

"""
    create_app_actest(p_open::Ref{Bool})

Create an UI window for the ACTest toolkit, which is used to benchmark the
analytic continuation tools in the ACFlow package.
"""
function create_app_actest(p_open::Ref{Bool})
    # Create the ACTest window, which is modal and can not be resized.
    CImGui.Begin(
        "ACTest",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ACTEST"
    end

    # Fix size of the window
    window_width = 400.0
    window_height = 300.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    CImGui.Text("ACTest")

    # End of this window
    CImGui.End()
end
