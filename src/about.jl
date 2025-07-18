#
# Project : Camellia
# Source  : about.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/06/27
#

"""
    create_app_about(p_open::Ref{Bool}, logo_id)

Display the `About` window, which is used to show some userful information
about this ZenGui app.
"""
function create_app_about(p_open::Ref{Bool}, logo_id)
    # Create the About window, which is modal and can not be resized.
    CImGui.Begin(
        "About ZenGui",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    # Fix size of the window
    window_width = 400.0
    window_height = 360.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # Show header
    #
    # Setup the logo image, which is already loaded in load_logo().
    scale = 20.0
    logo_width = 4188.0 / scale
    logo_height = 1372.0 / scale
    #
    # We want to make sure the logo is shown in the middle of the window.
    offset = (window_width - logo_width) / 2.0
    CImGui.SameLine(offset)
    CImGui.Image(logo_id, (logo_width, logo_height), (0.0, 1.0), (1.0, 0.0))
    #
    CImGui.Spacing()
    CImGui.TextWrapped("A general-purposed graphic user interface " *
        "for ab initio dynamical mean-field theory codes")

    # Vertical space
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Dummy(ImVec2(0.0,10.0))

    # Show author
    CImGui.TextColored(COL_MAGENTA, "Author :")
    CImGui.SameLine()
    CImGui.Text(__AUTHORS__[1].name)

    # Show email
    CImGui.TextColored(COL_MAGENTA, "Contact:")
    CImGui.SameLine()
    CImGui.Text(__AUTHORS__[1].email)

    # Show version
    CImGui.TextColored(COL_MAGENTA, "Version:")
    CImGui.SameLine()
    CImGui.Text("v$(__VERSION__)")

    # Show license
    CImGui.TextColored(COL_MAGENTA, "License:")
    CImGui.SameLine()
    CImGui.Text("GNU General Public License Version 3")

    # Show github url
    CImGui.TextColored(COL_MAGENTA, "Github :")
    CImGui.SameLine()
    CImGui.Text("https://github.com/huangli712/ZenGui")

    # Show footer
    CImGui.Spacing()
    CImGui.TextWrapped("Powered by the Julia language (v$VERSION) " *
        "and the Dear ImGui library (v$(CImGui.IMGUI_VERSION)).")
    CImGui.Dummy(ImVec2(0.0,10.0))

    # Create a `OK` button. It will reset `p_open`.
    #
    # Set button's geometry
    button_width = 80.0
    button_height = 25.0
    #
    if CImGui.Button("OK", ImVec2(button_width, button_height))
        p_open[] = false
    end

    # End of this window
    CImGui.End()
end
