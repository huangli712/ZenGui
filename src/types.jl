#
# Project : Camellia
# Source  : types.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/01
#

mutable struct MenuFlags
    ZEN      :: Bool
    DYSON    :: Bool
    DFERMION :: Bool
    CTSEG    :: Bool
    CTHYB    :: Bool
    ATOMIC   :: Bool
    ACFLOW   :: Bool
    ACTEST   :: Bool
    ABOUT    :: Bool
    _EXIT    :: Bool
end

FMENU = MenuFlags(
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
)
