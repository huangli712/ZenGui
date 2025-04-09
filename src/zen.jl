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
    # Create the Zen window, which can not be resized.
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
    window_width = 600.0
    window_height = 400.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    _zen_tabs()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # End of this window
    CImGui.End()
end

"""
    _zen_tabs()

Setup the tab widgets for all the blocks in the case.toml.
"""
function _zen_tabs()
    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    #
    if CImGui.BeginTabBar("MyTabBar", tab_bar_flags)
        _zen_case_tab()
        _zen_dft_tab()
        _zen_dmft_tab()
        _zen_imp_tab()
        _zen_solver_tab()
        #
        CImGui.EndTabBar()
    end
end

function _zen_case_tab()
    if CImGui.BeginTabItem("Avocado")
        CImGui.Text("This is the Avocado tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end

function _zen_dft_tab()
    if CImGui.BeginTabItem("Broccoli")
        CImGui.Text("This is the Broccoli tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end

function _zen_dmft_tab()
    if CImGui.BeginTabItem("Cucumber")
        CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end

function _zen_imp_tab()
end

function _zen_solver_tab()
end
