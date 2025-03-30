#
# Project : Camellia
# Source  : about.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/29
#

function create_app_about(p_open::Ref{Bool})
    #CImGui.OpenPopup("Delete?")
    #if CImGui.BeginPopupModal("Delete?", C_NULL, CImGui.ImGuiWindowFlags_AlwaysAutoResize)
    #    CImGui.Button("OK", (120, 0)) && CImGui.CloseCurrentPopup()
    #    CImGui.EndPopup()
    #end

    #if CImGui.BeginPopupModal("Delete?", C_NULL, CImGui.ImGuiWindowFlags_AlwaysAutoResize)
    #    CImGui.Text("All those beautiful files will be deleted.\nThis operation cannot be undone!\n\n")
    #    CImGui.Separator()

    #    CImGui.Button("OK", (120, 0)) && CImGui.CloseCurrentPopup()
    #    CImGui.SetItemDefaultFocus()
    #    CImGui.SameLine()
    #    CImGui.Button("Cancel",(120, 0)) && CImGui.CloseCurrentPopup()
    #    CImGui.EndPopup()
    #end

    CImGui.Begin("About Dear ImGui", p_open, CImGui.ImGuiWindowFlags_AlwaysAutoResize) || (CImGui.End(); return)
    CImGui.Text("Dear ImGui $(CImGui.IMGUI_VERSION)")
    CImGui.Separator()
    CImGui.Text("By Omar Cornut and all dear imgui contributors.")
    CImGui.Text("Dear ImGui is licensed under the MIT License, see LICENSE for more information.")
    CImGui.End()
end
