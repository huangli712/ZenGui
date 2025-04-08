#
# Project : Camellia
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
#

function zeng_run()
    CImGui.set_backend(:GlfwOpenGL3)

    # setup Dear ImGui context
    ctx = CImGui.CreateContext()

    # enable docking and multi-viewport
    setup_flags()

    # When viewports are enabled we tweak WindowRounding/WindowBg so platform
    # windows can look identical to regular ones.
    setup_window()

    # Load Fonts
    setup_fonts()

    # setup Dear ImGui style
    CImGui.StyleColorsDark()

    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
    engine = nothing

    CImGui.render(ctx; engine, clear_color=Ref(clear_color), window_title = "ZenGui") do
        create_menu()

        FMENU._SAVE     && handle_menu_save()
        FMENU._EXIT     && return :imgui_exit_loop
        #
        FMENU.ZEN       && @c create_app_zen(&FMENU.ZEN)
        FMENU.DYSON     && @c create_app_dyson(&FMENU.DYSON)
        FMENU.DFERMION  && @c create_app_dfermion(&FMENU.DFERMION)
        FMENU.CTSEG     && @c create_app_ctseg(&FMENU.CTSEG)
        FMENU.CTHYB     && @c create_app_cthyb(&FMENU.CTHYB)
        FMENU.ATOMIC    && @c create_app_atomic(&FMENU.ATOMIC)
        FMENU.ACFLOW    && @c create_app_acflow(&FMENU.ACFLOW)
        FMENU.ACTEST    && @c create_app_actest(&FMENU.ACTEST)
        #
        FMENU._CLASSIC  && handle_menu_classic()
        FMENU._DARK     && handle_menu_dark()
        FMENU._LIGHT    && handle_menu_light()
        #
        FMENU._ZEN      && handle_menu_zen()
        FMENU._DYSON    && handle_menu_dyson()
        FMENU._DFERMION && handle_menu_dfermion()
        FMENU._IQIST    && handle_menu_iqist()
        FMENU._ACFLOW   && handle_menu_acflow()
        FMENU._ACTEST   && handle_menu_actest()
        FMENU._ZENGUI   && handle_menu_zengui()
        FMENU._ABOUT    && @c create_app_about(&FMENU._ABOUT)
    end
end

"""
    handle_menu_save()
"""
function handle_menu_save()
    @show "IN SAVE MENU"

    @cswitch CWIN.name begin
        
        @case "ZEN"
            if FMENU.ZEN
                @show "SAVE ZEN"
            end
            break

        @case "DYSON"
            if FMENU.DYSON
                @show "SAVE DYSON"
            end
            break

        @case "DFERMION"
            if FMENU.DFERMION
                @show "SAVE DFERMION"
            end
            break

        @case "CTSEG"
            if FMENU.CTSEG
                @show "SAVE CTSEG"
            end
            break

        @case "CTHYB"
            if FMENU.CTHYB
                @show "SAVE CTHYB"
            end
            break

        @case "ATOMIC"
            if FMENU.ATOMIC
                @show "SAVE ATOMIC"
            end
            break

        @case "ACFLOW"
            if FMENU.ACFLOW
                @show "SAVE ACFLOW"
                @c save_acflow(&FMENU._SAVE)
            end
            break

        @case "ACTEST"
            if FMENU.ACTEST
                @show "SAVE ACTEST"
            end
            break

        @default
            FMENU._SAVE = false
            break

    end
end

function handle_menu_classic()
    CImGui.StyleColorsClassic()
    FMENU._CLASSIC = false
end

function handle_menu_dark()
    CImGui.StyleColorsDark()
    FMENU._DARK = false
end

function handle_menu_light()
    CImGui.StyleColorsLight()
    FMENU._LIGHT = false
end

function handle_menu_zen()
    @show "HELP ZEN"
    FMENU._ZEN = false
end

function handle_menu_dyson()
    @show "HELP DYSON"
    FMENU._DYSON = false
end

function handle_menu_dfermion()
    @show "HELP DFERMION"
    FMENU._DFERMION = false
end

function handle_menu_iqist()
    @show "HELP IQIST"
    FMENU._IQIST = false
end

function handle_menu_acflow()
    @show "HELP ACFLOW"
    FMENU._ACFLOW = false
end

function handle_menu_actest()
    @show "HELP ACTEST"
    FMENU._ACTEST = false
end

function handle_menu_zengui()
    @show "HELP ZENGUI"
    FMENU._ZENGUI = false
end
