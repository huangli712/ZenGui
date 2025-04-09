#
# Project : Camellia
# Source  : zen.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/4/09
#

"""
    create_app_zen(p_open::Ref{Bool})

Create an UI window for the Zen toolkit, which is an integrated package for
ab initio dynamical mean-field theory calculations.
"""
function create_app_zen(p_open::Ref{Bool})
    # Create the Zen window, which is modal and can not be resized.
    CImGui.Begin(
        "Zen",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ZEN"
    end

    # Fix size of the window
    window_width = 400.0
    window_height = 300.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    if CImGui.BeginTabBar("MyTabBar", tab_bar_flags)
        if CImGui.BeginTabItem("Avocado")
            CImGui.Text("This is the Avocado tab!\nblah blah blah blah blah")
            CImGui.EndTabItem()
        end
        if CImGui.BeginTabItem("Broccoli")
            CImGui.Text("This is the Broccoli tab!\nblah blah blah blah blah")
            CImGui.EndTabItem()
        end
        if CImGui.BeginTabItem("Cucumber")
            CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
            CImGui.EndTabItem()
        end
        CImGui.EndTabBar()
    end


    # End of this window
    CImGui.End()
end