#
# Project : Camellia
# Source  : save.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
#

"""
    save_acflow()
"""
function save_acflow()
    CImGui.OpenPopup("Save")
    #
    if CImGui.BeginPopupModal("Save", C_NULL, CImGui.ImGuiWindowFlags_AlwaysAutoResize)
        file = joinpath(pwd(), "ac.toml")
        CImGui.Text("The configurtion file for ACFlow will be saved at $file.")
        #
        if CImGui.Button("OK")
            CImGui.CloseCurrentPopup()
        end
        #
        CImGui.EndPopup()
    end
    #
    D = _build_acflow_dict()
    open("ac.toml", "w") do fout
        TOML.print(fout, D)
    end
end
