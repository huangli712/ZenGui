#
# Project : Camellia
# Source  : zen.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/4/10
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

    # For all the blocks in the case.toml
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
    if CImGui.BeginTabBar("ZenTabBar", tab_bar_flags)
        _zen_case_tab()
        _zen_dft_tab()
        _zen_dmft_tab()
        _zen_imp_tab()
        _zen_solver_tab()
        #
        CImGui.EndTabBar()
    end
end

"""
    _zen_case_tab()
"""
function _zen_case_tab()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("case")
        CImGui.Text("Configure [case] block")

        # Input: case
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic buf = "SrVO3" * "\0"^60 begin
            CImGui.InputText(" System's name or seedname", buf, length(buf))
            PCASE.case = rstrip(buf,'\0')
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(case)$(PCASE.case)")

        CImGui.EndTabItem()
    end
end

"""
    _zen_dft_tab()
"""
function _zen_dft_tab()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("dft")
        CImGui.Text("Configure [dft] block")

        # Input: engine
        CImGui.SetNextItemWidth(widget_combo_width)
        engine_list = ["vasp", "qe"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Engine for density functional theory calculations", &id, engine_list)
            PDFT.engine = engine_list[id + 1]
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(engine)$(PDFT.engine)")

        CImGui.EndTabItem()
    end
end

"""
    _zen_dmft_tab()
"""
function _zen_dmft_tab()
    if CImGui.BeginTabItem("dmft")
        CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end

"""
    _zen_imp_tab()
"""
function _zen_imp_tab()
    if CImGui.BeginTabItem("impurity")
        CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end

"""
    _zen_solver_tab()
"""
function _zen_solver_tab()
    if CImGui.BeginTabItem("solver")
        CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end
