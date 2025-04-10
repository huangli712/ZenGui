#
# Project : Camellia
# Source  : save.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/10
#

"""
    save_zen(p_open::Ref{Bool})
"""
function save_zen(p_open::Ref{Bool})
    # Create a popup window
    CImGui.Begin(
        "Save Zen",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    file = joinpath(pwd(), "case.toml")
    CImGui.Text("The configurtion file for Zen will be saved at:")
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "  $file")

    # If the button is pressed, then the ac.toml file is stored in the
    # current directory.
    if CImGui.Button("Save It")
        p_open[] = false
        #
        D = _build_zen_dict()
        open("case.toml", "w") do fout
            TOML.print(fout, D)
        end
    end

    # Close the popup window
    CImGui.End()
end

"""
    save_dyson(p_open::Ref{Bool})
"""
function save_dyson(p_open::Ref{Bool})

end

"""
    save_dfermion(p_open::Ref{Bool})
"""
function save_dfermion(p_open::Ref{Bool})

end

"""
    save_ctseg(p_open::Ref{Bool})
"""
function save_ctseg(p_open::Ref{Bool})

end

"""
    save_cthyb(p_open::Ref{Bool})
"""
function save_cthyb(p_open::Ref{Bool})

end

"""
    save_atomic(p_open::Ref{Bool})
"""
function save_atomic(p_open::Ref{Bool})

end

"""
    save_acflow(p_open::Ref{Bool})
"""
function save_acflow(p_open::Ref{Bool})
    # Create a popup window
    CImGui.Begin(
        "Save ACFlow",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    file = joinpath(pwd(), "ac.toml")
    CImGui.Text("The configurtion file for ACFlow will be saved at:")
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "  $file")

    # If the button is pressed, then the ac.toml file is stored in the
    # current directory.
    if CImGui.Button("Save It")
        p_open[] = false
        #
        D = _build_acflow_dict()
        open("ac.toml", "w") do fout
            TOML.print(fout, D)
        end
    end

    # Close the popup window
    CImGui.End()
end

"""
    save_actest(p_open::Ref{Bool})
"""
function save_actest(p_open::Ref{Bool})
    # Create a popup window
    CImGui.Begin(
        "Save ACTest",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    file = joinpath(pwd(), "act.toml")
    CImGui.Text("The configurtion file for ACTest will be saved at:")
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "  $file")

    # If the button is pressed, then the act.toml file is stored in the
    # current directory.
    if CImGui.Button("Save It")
        p_open[] = false
        #
        D = _build_actest_dict()
        open("act.toml", "w") do fout
            TOML.print(fout, D)
        end
    end

    # Close the popup window
    CImGui.End()
end

"""
    save_nothing(p_open::Ref{Bool})
"""
function save_nothing(p_open::Ref{Bool})
    # Create a popup window
    CImGui.Begin(
        "Save Nothing",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "Nothing to be saved!")

    # If the button is pressed, then close this window.
    if CImGui.Button("Close")
        p_open[] = false
    end

    # Close the popup window
    CImGui.End()
end
