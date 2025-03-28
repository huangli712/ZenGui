#
# Project : Camellia
# Source  : menu.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/28
#

function create_menu()
    if CImGui.BeginMainMenuBar()
        set_menu_file()
        set_menu_edit()
        set_menu_help()
        #
        CImGui.EndMainMenuBar()
    end
end

function set_menu_file()
    if CImGui.BeginMenu("File")
        if CImGui.MenuItem("Exit")
            @info "Trigger Exit"
        end
        CImGui.EndMenu()
    end
end

function set_menu_edit()
    if CImGui.BeginMenu("Edit")
        CImGui.EndMenu()
    end
end

function set_menu_help()
    if CImGui.BeginMenu("Help")
        if CImGui.MenuItem("About ZenGui")
        end
        CImGui.EndMenu()
    end
end
