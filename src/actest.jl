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
    # Create the ACTest window, which can not be resized.
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
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For the [Test] block in the act.toml
    _actest_test_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # End of this window
    CImGui.End()
end

"""
    _actest_test_block()

Setup widgets for the [Test] block in the act.toml.
"""
function _actest_test_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    CImGui.Text("Basic Configuration")
end
