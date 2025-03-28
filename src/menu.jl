#
# Project : Camellia
# Source  : menu.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/28
#

"""
    create_menu

Generate menu in the main window.
"""
function create_menu()
    if CImGui.BeginMainMenuBar()
        set_menu_file()
        set_menu_edit()
        set_menu_help()
        #
        CImGui.EndMainMenuBar()
    end
end

"""
    set_menu_file

Setup items in menu ``File''. 
"""
function set_menu_file()
    if CImGui.BeginMenu("File")
        if CImGui.MenuItem("Exit")
            @info "Trigger Exit"
        end
        CImGui.EndMenu()
    end
end

"""
   set_menu_edit

Setup items in menu ``Edit''. 
"""
function set_menu_edit()
    if CImGui.BeginMenu("Edit")
        CImGui.EndMenu()
    end
end

"""
   set_menu_help

Setup items in menu ``Help''. 
"""
function set_menu_help()
    if CImGui.BeginMenu("Help")
        if CImGui.BeginMenu("Documentation")
            if CImGui.MenuItem("Zen")
            end
            #
            CImGui.Separator()
            # 
            if CImGui.MenuItem("Dyson")
            end
            if CImGui.MenuItem("DFermion")
            end
            if CImGui.MenuItem("iQIST")
            end
            #
            CImGui.Separator()
            #
            if CImGui.MenuItem("ACFlow")
            end
            if CImGui.MenuItem("ACTest")
            end
            #
            CImGui.EndMenu()
        end
        #
        CImGui.Separator()
        #
        if CImGui.MenuItem("User's manual")
        end
        if CImGui.MenuItem("About ZenGui")
        end
        #
        CImGui.EndMenu()
    end
end
