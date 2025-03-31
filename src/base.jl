#
# Project : Camellia
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/31
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

    global show_app_acflow
    global show_app_actest
    global show_app_about
    CImGui.render(ctx; engine, clear_color=Ref(clear_color), window_title = "ZenGui") do
        create_menu()

        show_app_acflow && @c create_app_acflow(&show_app_acflow)
        show_app_actest && @c create_app_actest(&show_app_actest)
        show_app_about && @c create_app_about(&show_app_about)
    end
end
