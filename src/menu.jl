#
# Project : Camellia
# Source  : menu.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/28
#

function create_main_menu()
    if CImGui.BeginMainMenuBar()
        if CImGui.BeginMenu("File")
            if CImGui.MenuItem("Exit", "CTRL+Z")
                @info "Trigger Exit | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            CImGui.EndMenu()
        end
        #
        if CImGui.BeginMenu("Edit")
            CImGui.EndMenu()
        end
        #
        if CImGui.BeginMenu("Help")
            if CImGui.MenuItem("About ZenGui")
            end
            CImGui.EndMenu()
        end
        CImGui.EndMainMenuBar()
    end
end