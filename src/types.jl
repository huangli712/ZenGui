#
# Project : Camellia
# Source  : types.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/01
#

mutable struct MenuFlags
    ABOUT :: Bool
end

FMENU = MenuFlags(false)