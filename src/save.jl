#
# Project : Camellia
# Source  : save.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
#

function save_acflow()
    D = _build_acflow_dict()
    open("ac.toml", "w") do fout
        TOML.print(fout, D)
    end
end
