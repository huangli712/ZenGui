#
# Project : Camellia
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/01
#

function zeng_run()
    CImGui.set_backend(:GlfwOpenGL3)

    # setup Dear ImGui context
    ctx = CImGui.CreateContext()

    # enable docking and multi-viewport
    setup_config_flags()

    # setup Dear ImGui style
    CImGui.StyleColorsDark()

    # When viewports are enabled we tweak WindowRounding/WindowBg so platform
    # windows can look identical to regular ones.
    tweak_window()

    # Load Fonts
    setup_fonts()

    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
    engine = nothing

    CImGui.render(ctx; engine, clear_color=Ref(clear_color), window_title = "ZenGui") do
        create_menu()

        FMENU._OPEN    && @show "OPEN"
        FMENU._SAVE    && @show "SAVE"
        FMENU._EXIT    && return :imgui_exit_loop
        #
        FMENU.ZEN      && @c create_app_zen(&FMENU.ZEN)
        FMENU.DYSON    && @c create_app_dyson(&FMENU.DYSON)
        FMENU.DFERMION && @c create_app_dyson(&FMENU.DFERMION)
        FMENU.CTSEG    && @c create_app_ctseg(&FMENU.CTSEG)
        FMENU.CTHYB    && @c create_app_cthyb(&FMENU.CTHYB)
        FMENU.ATOMIC   && @c create_app_atomic(&FMENU.ATOMIC)
        FMENU.ACFLOW   && @c create_app_acflow(&FMENU.ACFLOW)
        FMENU.ACTEST   && @c create_app_actest(&FMENU.ACTEST)
        #
        FMENU._CLASSIC && change_style()
        FMENU._DARK    && change_style()
        FMENU._LIGHT   && change_style()
        #
        FMENU._ZEN     && @show "HELP ZEN"
        FMENU._DYSON   && @show "HELP DYSON"
        FMENU.ABOUT    && @c create_app_about(&FMENU.ABOUT)
    end
end
