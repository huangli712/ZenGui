#
# Project : Camellia
# Source  : about.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/29
#

function create_app_about(p_open::Ref{Bool})
    CImGui.Begin("About Dear ImGui", p_open, CImGui.ImGuiWindowFlags_AlwaysAutoResize) || (CImGui.End(); return)
    CImGui.Text("Dear ImGui $(CImGui.IMGUI_VERSION)")
    CImGui.Separator()
    CImGui.Text("By Omar Cornut and all dear imgui contributors.")
    CImGui.Text("Dear ImGui is licensed under the MIT License, see LICENSE for more information.")
    if CImGui.Button("OK", (120, 0)) 
        p_open[] = false
        @show "hhhhhh"
    end
    CImGui.End()
end
