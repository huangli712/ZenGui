#
# Project : Camellia
# Source  : menu.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/29
#

"""
    create_menu()

Generate menu in the main window.
"""
function create_menu()
    if CImGui.BeginMainMenuBar()
        set_menu_file()
        set_menu_edit()
        set_menu_style()
        set_menu_help()
        #
        CImGui.EndMainMenuBar()
    end
end

"""
    set_menu_file()

Setup items in menu ``File''. 
"""
function set_menu_file()
    if CImGui.BeginMenu("File")
        if CImGui.MenuItem("Open...")
            @info "Trigger File -> Open..."
        end
        #
        CImGui.Separator()
        # 
        if CImGui.MenuItem("Exit")
            @info "Trigger File -> Exit"
        end
        #
        CImGui.EndMenu()
    end
end

"""
   set_menu_edit()

Setup items in menu ``Edit''. 
"""
function set_menu_edit()
    if CImGui.BeginMenu("Edit")
        if CImGui.BeginMenu("Integrated Package")
            if CImGui.MenuItem("Zen")
                @info "Trigger Edit -> Integrated Package -> Zen"
            end
            #
            CImGui.EndMenu()
        end
        #
        if CImGui.BeginMenu("Dynamical Mean-Field Theory")
            if CImGui.MenuItem("Dyson")
                @info "Trigger Edit -> Dynamical Mean-Field Theory -> Dyson"
            end
            if CImGui.MenuItem("DFermion")
                @info "Trigger Edit -> Dynamical Mean-Field Theory -> DFermion"
            end
            #
            CImGui.EndMenu()
        end
        #
        if CImGui.BeginMenu("Quantum Impurity Solvers")
            if CImGui.MenuItem("iQIST | CTSEG")
                @info "Trigger Edit -> Quantum Impurity Solvers -> iQIST | CTSEG"
            end
            if CImGui.MenuItem("iQIST | CTHYB")
                @info "Trigger Edit -> Quantum Impurity Solvers -> iQIST | CTHYB"
            end
            if CImGui.MenuItem("iQIST | ATOMIC")
                @info "Trigger Edit -> Quantum Impurity Solvers -> iQIST | ATOMIC"
            end
            #
            CImGui.EndMenu()
        end
        #
        if CImGui.BeginMenu("Analytic Continuation")
            if CImGui.MenuItem("ACFlow")
                @info "Trigger Edit -> Analytic Continuation -> ACFlow"
            end
            if CImGui.MenuItem("ACTest")
                @info "Trigger Edit -> Analytic Continuation -> ACTest"
            end
            #
            CImGui.EndMenu()
        end
        #
        CImGui.EndMenu()
    end
end

"""
   set_menu_style()

Setup items in menu ``Style''. 
"""
function set_menu_style()
    if CImGui.BeginMenu("Style")
        if CImGui.MenuItem("Classic")
            CImGui.StyleColorsClassic()
            @info "Trigger Style -> Classic"
        end
        if CImGui.MenuItem("Dark")
            CImGui.StyleColorsDark()
            @info "Trigger Style -> Dark"
        end
        if CImGui.MenuItem("Light")
            CImGui.StyleColorsLight()
            @info "Trigger Style -> Light"
        end
        #
        CImGui.EndMenu()
    end
end

"""
   set_menu_help()

Setup items in menu ``Help''. 
"""
function set_menu_help()
    if CImGui.BeginMenu("Help")
        if CImGui.BeginMenu("Documentation")
            if CImGui.MenuItem("Zen")
                @info "Trigger Help -> Documentation -> Zen"
            end
            #
            CImGui.Separator()
            # 
            if CImGui.MenuItem("Dyson")
                @info "Trigger Help -> Documentation -> Dyson"
            end
            if CImGui.MenuItem("DFermion")
                @info "Trigger Help -> Documentation -> DFermion"
            end
            #
            CImGui.Separator()
            #
            if CImGui.MenuItem("iQIST")
                @info "Trigger Help -> Documentation -> iQIST"
            end
            #
            CImGui.Separator()
            #
            if CImGui.MenuItem("ACFlow")
                @info "Trigger Help -> Documentation -> ACFlow"
            end
            if CImGui.MenuItem("ACTest")
                @info "Trigger Help -> Documentation -> ACTest"
            end
            #
            CImGui.EndMenu()
        end
        #
        CImGui.Separator()
        #
        if CImGui.MenuItem("User's manual")
            @info "Trigger Help -> User's manual"
        end
        global show_app_about
        @c CImGui.MenuItem("About ZenGui", C_NULL, &show_app_about)
        #
        CImGui.EndMenu()
    end
end
