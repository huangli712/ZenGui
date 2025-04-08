#
# Project : Camellia
# Source  : save.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/09
#

"""
    save_acflow(p_open::Ref{Bool})
"""
function save_acflow(p_open::Ref{Bool})
    CImGui.Begin(
        "Save ACFlow",
        p_open,
        CImGui.ImGuiWindowFlags_Modal | CImGui.ImGuiWindowFlags_NoResize
    )

    file = joinpath(pwd(), "ac.toml")
    CImGui.Text("The configurtion file for ACFlow will be saved at:")
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "  $file")

    if CImGui.Button("Save It")
        p_open[] = false
        #
        D = _build_acflow_dict()
        open("ac.toml", "w") do fout
            TOML.print(fout, D)
        end
    end

    CImGui.End()
end
