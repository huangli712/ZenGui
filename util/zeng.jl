using CImGui
using CImGui.lib
using CImGui.CSyntax

import GLFW
import ModernGL as GL

CImGui.set_backend(:GlfwOpenGL3)

# setup Dear ImGui context
ctx = CImGui.CreateContext()

# enable docking and multi-viewport
io = CImGui.GetIO()
io.ConfigFlags = unsafe_load(io.ConfigFlags) | CImGui.ImGuiConfigFlags_DockingEnable
io.ConfigFlags = unsafe_load(io.ConfigFlags) | CImGui.ImGuiConfigFlags_ViewportsEnable

# When viewports are enabled we tweak WindowRounding/WindowBg so platform
# windows can look identical to regular ones.
style = Ptr{ImGuiStyle}(CImGui.GetStyle())
if unsafe_load(io.ConfigFlags) & ImGuiConfigFlags_ViewportsEnable == ImGuiConfigFlags_ViewportsEnable
    style.WindowRounding = 5.0f0
    col = CImGui.c_get(style.Colors, CImGui.ImGuiCol_WindowBg)
    CImGui.c_set!(style.Colors, CImGui.ImGuiCol_WindowBg, ImVec4(col.x, col.y, col.z, 1.0f0))
end

clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
engine = nothing

CImGui.render(ctx; engine, clear_color=Ref(clear_color), window_title = "ZenGui") do
    if CImGui.BeginMainMenuBar()
        if CImGui.BeginMenu("Edit")
            if CImGui.MenuItem("Undo", "CTRL+Z")
                @info "Trigger Undo | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            if CImGui.MenuItem("Redo", "CTRL+Y", false, false)  # disabled item
                @info "Trigger Redo | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            CImGui.Separator()
            if CImGui.MenuItem("Cut", "CTRL+X")
                @info "Trigger Cut | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            if CImGui.MenuItem("Copy", "CTRL+C")
                @info "Trigger Copy | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            if CImGui.MenuItem("Paste", "CTRL+V")
                @info "Trigger Paste | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            CImGui.EndMenu()
        end
        CImGui.EndMainMenuBar()
    end
end

println("hehe")