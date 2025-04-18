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

    # For all the blocks in the dfa.in
    _dfermion_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _dfermion_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _dfermion_tabs_block()

Setup the tab widgets for all the blocks in the dfa.in.
"""
function _dfermion_tabs_block()
    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    #
    if CImGui.BeginTabBar("dfermionTabBar", tab_bar_flags)
        _dfermion_model_block()
        _dfermion_dim_block()
        _dfermion_kmesh_block()
        _dfermion_cycle_block()
        #
        CImGui.EndTabBar()
    end
end
