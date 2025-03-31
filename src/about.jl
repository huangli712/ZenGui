#
# Project : Camellia
# Source  : about.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/31
#

"""
    create_app_about(p_open::Ref{Bool})

Display the `About` window, which is used to show some userful information
for users.
"""
function create_app_about(p_open::Ref{Bool})
    # Create the about window, which is modal and can not be resized.
    flags = CImGui.ImGuiWindowFlags_Modal && CImGui.ImGuiWindowFlags_NoResize
    CImGui.Begin("About ZenGui", p_open, flags)
    CImGui.SetWindowSize(ImVec2(400.0,300.0))
    
    #CImGui.SameLine(150)
    #CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "ZenGui")
    win_width = CImGui.GetWindowWidth()
    txt_width = CImGui.CalcTextSize("ZenGui").x
    offset = (win_width - txt_width) / 2.0
    CImGui.SameLine(offset)
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "ZenGui")

    CImGui.Spacing()
    CImGui.TextWrapped("A general-purposed graphic user interface for ab initio dynamical mean-field theory codes")


    CImGui.Separator()
    CImGui.Text("Dear ImGui $(CImGui.IMGUI_VERSION)")
    
    CImGui.Text("By Omar Cornut and all dear imgui contributors.")
    CImGui.Text("Dear ImGui is licensed under the MIT License, see LICENSE for more information.")
    if CImGui.Button("OK", (120, 0)) 
        p_open[] = false
    end
    CImGui.End()
end
