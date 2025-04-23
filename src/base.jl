#
# Project : Camellia
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/23
#

#=
### *Main Loop*
=#

"""
    zeng_run()

Main function. It launchs the graphic user interface and respond to user
inputs unitl the main window is closed.
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

    # Setup color's style for Dear ImGui
    CImGui.StyleColorsDark()

    # Setup background color
    bgc = Cfloat[0.45, 0.55, 0.60, 1.00]

    CImGui.render(ctx; clear_color=Ref(bgc), window_title = "ZenGui") do
        # Setup global menu in the main window
        create_menu()

        # Respond to menu events
        #
        # For File menu
        FMENU.F_SAVE     && handle_menu_save()
        FMENU.F_EXIT     && return :imgui_exit_loop
        #
        # For Edit menu
        FMENU.E_ZEN      && @c create_app_zen(&FMENU.E_ZEN)
        FMENU.E_DYSON    && @c create_app_dyson(&FMENU.E_DYSON)
        FMENU.E_DFERMION && @c create_app_dfermion(&FMENU.E_DFERMION)
        FMENU.E_CTSEG    && @c create_app_ctseg(&FMENU.E_CTSEG)
        FMENU.E_CTHYB    && @c create_app_cthyb(&FMENU.E_CTHYB)
        FMENU.E_ATOMIC   && @c create_app_atomic(&FMENU.E_ATOMIC)
        FMENU.E_ACFLOW   && @c create_app_acflow(&FMENU.E_ACFLOW)
        FMENU.E_ACTEST   && @c create_app_actest(&FMENU.E_ACTEST)
        #
        # For Style menu
        FMENU.S_CLASSIC  && @c handle_menu_classic(&FMENU.S_CLASSIC)
        FMENU.S_DARK     && @c handle_menu_dark(&FMENU.S_DARK)
        FMENU.S_LIGHT    && @c handle_menu_light(&FMENU.S_LIGHT)
        #
        # For Help menu
        FMENU.H_ZEN      && @c handle_menu_zen(&FMENU.H_ZEN)
        FMENU.H_DYSON    && @c handle_menu_dyson(&FMENU.H_DYSON)
        FMENU.H_DFERMION && @c handle_menu_dfermion(&FMENU.H_DFERMION)
        FMENU.H_IQIST    && @c handle_menu_iqist(&FMENU.H_IQIST)
        FMENU.H_ACFLOW   && @c handle_menu_acflow(&FMENU.H_ACFLOW)
        FMENU.H_ACTEST   && @c handle_menu_actest(&FMENU.H_ZENGUI)
        FMENU.H_ZENGUI   && @c handle_menu_zengui(&FMENU.H_ZENGUI)
        FMENU.H_ABOUT    && @c create_app_about(&FMENU.H_ABOUT)
    end
end

#=
### *Configure Application*
=#

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

#=
### *Menu Handler*
=#

"""
    handle_menu_save()

Respond the menu event: save. Try to save configurtion files for various
tools or codes.
"""
function handle_menu_save()
    @cswitch CWIN.name begin

        @case "ZEN"
            if FMENU.E_ZEN
                @c save_zen(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "DYSON"
            if FMENU.E_DYSON
                @c save_dyson(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "DFERMION"
            if FMENU.E_DFERMION
                @c save_dfermion(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "CTSEG"
            if FMENU.E_CTSEG
                @c save_ctseg(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "CTHYB"
            if FMENU.E_CTHYB
                @c save_cthyb(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "ATOMIC"
            if FMENU.E_ATOMIC
                @c save_atomic(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "ACFLOW"
            if FMENU.E_ACFLOW
                @c save_acflow(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @case "ACTEST"
            if FMENU.E_ACTEST
                @c save_actest(&FMENU.F_SAVE)
            else
                FMENU.F_SAVE = false
            end
            break

        @default
            @c save_nothing(&FMENU.F_SAVE)
            break

    end
end

"""
    handle_menu_classic(p_open::Ref{Bool})

Respond the menu event: classic. Change the appearance of graphic user
interface to classic style.
"""
function handle_menu_classic(p_open::Ref{Bool})
    CImGui.StyleColorsClassic()
    p_open[] = false
end

"""
    handle_menu_dark(p_open::Ref{Bool})

Respond the menu event: dark. Change the appearance of graphic user
interface to dark style. Note that the defalt style is dark.
"""
function handle_menu_dark(p_open::Ref{Bool})
    CImGui.StyleColorsDark()
    p_open[] = false
end

"""
    handle_menu_light(p_open::Ref{Bool})

Respond the menu event: light. Change the appearance of graphic user
interface to light style.
"""
function handle_menu_light(p_open::Ref{Bool})
    CImGui.StyleColorsLight()
    p_open[] = false
end

"""
    handle_menu_zen(p_open::Ref{Bool})

Respond the menu event: zen. Try to open documentation for the Zen package.
"""
function handle_menu_zen(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/zen/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    handle_menu_dyson(p_open::Ref{Bool})

Respond the menu event: dyson. Try to open documentation for the Dyson
code.
"""
function handle_menu_dyson(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/dyson/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    handle_menu_dfermion(p_open::Ref{Bool})

Respond the menu event: dfermion. Try to open documentation for the
DFermion code.
"""
function handle_menu_dfermion(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/dfermion/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    handle_menu_iqist(p_open::Ref{Bool})

Respond the menu event: iqist. Try to open documentation for the iQIST
package.
"""
function handle_menu_iqist(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/iqist_new/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    handle_menu_acflow(p_open::Ref{Bool})

Respond the menu event: acflow. Try to open documentation for the ACFlow
toolkit.
"""
function handle_menu_acflow(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/acflow/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    handle_menu_actest(p_open::Ref{Bool})

Respond the menu event: actest. Try to open documentation for the ACTest
toolkit.
"""
function handle_menu_actest(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/actest/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    handle_menu_zengui(p_open::Ref{Bool})

Respond the menu event: zengui. Try to open documentation for the ZenGui
application.
"""
function handle_menu_zengui(p_open::Ref{Bool})
    url = "https://huangli712.github.io/projects/zengui/index.html"
    _open_url(url)
    p_open[] = false
end

"""
    _open_url(url::String)

Invoke the default web browser to open the given url. It only supports the
windows, macos, and linux systems.
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
