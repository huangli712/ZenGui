#
# Project : Camellia
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/18
#

"""
    zeng_run()

Main function. It launchs the graphic user interface.
"""
function zeng_run()
    # Setup backend for Dear ImGui
    CImGui.set_backend(:GlfwOpenGL3)

    # Setup context for Dear ImGui
    ctx = CImGui.CreateContext()

    # Setup flags for Dear ImGui, enabling docking and multi-viewport.
    setup_flags()

    # Setup window's style
    #
    # When viewports are enabled, we tweak WindowRounding and WindowBg so
    # platform windows can look identical to regular ones.
    setup_window()

    # Load fonts
    setup_fonts()

    # Setup style for Dear ImGui
    CImGui.StyleColorsDark()

    # Setup background color
    bgc = Cfloat[0.45, 0.55, 0.60, 1.00]

    CImGui.render(ctx; clear_color=Ref(bgc), window_title = "ZenGui") do
        # Setup menu in the main window
        create_menu()

        # Respond to events
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
    setup_flags()

Setup configuration flags for the Dear ImGui library.
"""
function setup_flags()
    io = CImGui.GetIO()
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | CImGui.ImGuiConfigFlags_DockingEnable
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | CImGui.ImGuiConfigFlags_ViewportsEnable
    io.IniFilename = C_NULL
end

"""
    setup_fonts()

Setup fonts for this graphic user interface.
"""
function setup_fonts()
    fonts_dir = "/Users/lihuang/Library/Fonts"
    fonts = unsafe_load(CImGui.GetIO().Fonts)
    CImGui.AddFontFromFileTTF(
        fonts,
        joinpath(fonts_dir, "FiraCode-Regular.ttf"),
        16,
        C_NULL,
        CImGui.GetGlyphRangesGreek(fonts) # To display the Greek letters
    )
end

"""
    setup_window()

Tweak the window's style in this graphic user interface.
"""
function setup_window()
    style = Ptr{ImGuiStyle}(CImGui.GetStyle())
    style.AntiAliasedLines = true
    #
    io = CImGui.GetIO()
    if unsafe_load(io.ConfigFlags) & ImGuiConfigFlags_ViewportsEnable == ImGuiConfigFlags_ViewportsEnable
        style.WindowRounding = 5.0f0
        col = CImGui.c_get(style.Colors, CImGui.ImGuiCol_WindowBg)
        CImGui.c_set!(
            style.Colors,
            CImGui.ImGuiCol_WindowBg,
            ImVec4(col.x, col.y, col.z, 1.0f0)
        )
    end
end

"""
    handle_menu_save()

Respond the menu event: save. Try to save configurtion files for various
tools or codes.
"""
function handle_menu_save()
    @show "IN SAVE MENU"

    @cswitch CWIN.name begin

        @case "ZEN"
            if FMENU.ZEN
                @show "SAVE ZEN"
                @c save_zen(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "DYSON"
            if FMENU.DYSON
                @show "SAVE DYSON"
                @c save_dyson(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "DFERMION"
            if FMENU.DFERMION
                @show "SAVE DFERMION"
                @c save_dfermion(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "CTSEG"
            if FMENU.CTSEG
                @show "SAVE CTSEG"
                @c save_ctseg(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "CTHYB"
            if FMENU.CTHYB
                @show "SAVE CTHYB"
                @c save_cthyb(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "ATOMIC"
            if FMENU.ATOMIC
                @show "SAVE ATOMIC"
                @c save_atomic(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "ACFLOW"
            if FMENU.ACFLOW
                @show "SAVE ACFLOW"
                @c save_acflow(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @case "ACTEST"
            if FMENU.ACTEST
                @show "SAVE ACTEST"
                @c save_actest(&FMENU._SAVE)
            else
                FMENU._SAVE = false
            end
            break

        @default
            @c save_nothing(&FMENU._SAVE)
            break

    end
end

"""
    handle_menu_classic()

Respond the menu event: classic. Change the appearance of graphic user
interface to classic style.
"""
function handle_menu_classic()
    CImGui.StyleColorsClassic()
    FMENU._CLASSIC = false
end

"""
    handle_menu_dark()

Respond the menu event: dark. Change the appearance of graphic user
interface to dark style. Note that the defalt style is dark.
"""
function handle_menu_dark()
    CImGui.StyleColorsDark()
    FMENU._DARK = false
end

"""
    handle_menu_light()

Respond the menu event: light. Change the appearance of graphic user
interface to light style.
"""
function handle_menu_light()
    CImGui.StyleColorsLight()
    FMENU._LIGHT = false
end

"""
    handle_menu_zen()

Respond the menu event: zen. Try to open documentation for the Zen package.
"""
function handle_menu_zen()
    url = "https://huangli712.github.io/projects/zen/index.html"
    _open_url(url)
    FMENU._ZEN = false
end

"""
    handle_menu_dyson()

Respond the menu event: dyson. Try to open documentation for the Dyson code.
"""
function handle_menu_dyson()
    url = "https://huangli712.github.io/projects/dyson/index.html"
    _open_url(url)
    FMENU._DYSON = false
end

"""
    handle_menu_dfermion()

Respond the menu event: dfermion. Try to open documentation for the
DFermion code.
"""
function handle_menu_dfermion()
    url = "https://huangli712.github.io/projects/dfermion/index.html"
    _open_url(url)
    FMENU._DFERMION = false
end

"""
    handle_menu_iqist()

Respond the menu event: iqist. Try to open documentation for the iQIST
toolkit.
"""
function handle_menu_iqist()
    url = "https://huangli712.github.io/projects/iqist_new/index.html"
    _open_url(url)
    FMENU._IQIST = false
end

"""
    handle_menu_acflow()

Respond the menu event: acflow. Try to open documentation for the ACFlow
toolkit.
"""
function handle_menu_acflow()
    url = "https://huangli712.github.io/projects/acflow/index.html"
    _open_url(url)
    FMENU._ACFLOW = false
end

"""
    handle_menu_actest()

Respond the menu event: actest. Try to open documentation for the ACTest
toolkit.
"""
function handle_menu_actest()
    url = "https://huangli712.github.io/projects/actest/index.html"
    _open_url(url)
    FMENU._ACTEST = false
end

"""
    handle_menu_zengui()

Respond the menu event: zengui. Try to open documentation for the ZenGui
application.
"""
function handle_menu_zengui()
    url = "https://huangli712.github.io/projects/zengui/index.html"
    _open_url(url)
    FMENU._ZENGUI = false
end

"""
    _open_url(url::String)

Invoke a web browser to open the given url.
"""
function _open_url(url::String)
    if Sys.iswindows()
        run(`start $url`)
    elseif Sys.islinux()
        run(`xdg-open $url`)
    elseif Sys.isapple()
        run(`open $url`)
    else
        sorry()
    end
end
