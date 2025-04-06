#
# Project : Camellia
# Source  : types.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/06
#

"""
    MenuFlags
"""
mutable struct MenuFlags
    _OPEN     :: Bool
    _SAVE     :: Bool
    _EXIT     :: Bool
    #
    ZEN       :: Bool
    DYSON     :: Bool
    DFERMION  :: Bool
    CTSEG     :: Bool
    CTHYB     :: Bool
    ATOMIC    :: Bool
    ACFLOW    :: Bool
    ACTEST    :: Bool
    #
    _CLASSIC  :: Bool
    _DARK     :: Bool
    _LIGHT    :: Bool
    #
    _ZEN      :: Bool
    _DYSON    :: Bool
    _DFERMION :: Bool
    _IQIST    :: Bool
    _ACFLOW   :: Bool
    _ACTEST   :: Bool
    _ZENGUI   :: Bool
    _ABOUT    :: Bool
end

"""
    FMENU
"""
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
    false,
    false,
    false,
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

"""
    ACFLOW_PBASE
"""
mutable struct ACFLOW_PBASE
    finput  :: String
    solver  :: String
    ktype   :: String
    mtype   :: String
    grid    :: String
    mesh    :: String
    ngrid   :: I64
    nmesh   :: I64
    wmax    :: F64
    wmin    :: F64
    beta    :: F64
    offdiag :: Bool
    fwrite  :: Bool
end

"""
    PBASE
"""
PBASE = ACFLOW_PBASE(
    "giw.data",
    "MaxEnt",
    "fermi",
    "flat",
    "ffreq",
    "linear",
    10,
    501,
    5.0,
    -5.0,
    10.0,
    false,
    true
)

mutable struct ACFLOW_PMaxEnt
    method :: String
    stype  :: String
    nalph  :: I64
    alpha  :: F64
    ratio  :: F64
    blur   :: F64
end

PMaxEnt = ACFLOW_PMaxEnt(
    "chi2kink",
    "sj",
    12,
    1e9,
    10.0,
    -1.0
)

mutable struct ACFLOW_PBarRat
    atype   :: String
    denoise :: String
    epsilon :: F64
    pcut    :: F64
    eta     :: F64
end

PBarRat = ACFLOW_PBarRat(
    "cont",
    "prony",
    1e-10,
    1e-3,
    1e-2
)

mutable struct ACFLOW_PNevanAC
    pick  :: Bool
    hardy :: Bool
    hmax  :: I64
    alpha :: F64
    eta   :: F64
end

PNevanAC = ACFLOW_PNevanAC(
    true,
    true,
    50,
    1e-4,
    1e-2
)

mutable struct ACFLOW_PStochAC
    nfine :: I64
    ngamm :: I64
    nwarm :: I64
    nstep :: I64
    ndump :: I64
    nalph :: I64
    alpha :: F64
    ratio :: F64
end

PStochAC = ACFLOW_PStochAC(
    10000,
    512,
    4000,
    4000000,
    40000,
    20,
    1.00,
    1.20
)

mutable struct ACFLOW_PStochSK
    method :: String
    nfine  :: I64
    ngamm  :: I64
    nwarm  :: I64
    nstep  :: I64
    ndump  :: I64
    retry  :: I64
    theta  :: F64
    ratio  :: F64
end

PStochSK = ACFLOW_PStochSK(
    "chi2min",
    100000,
    1000,
    1000,
    20000,
    200,
    10,
    1e+6,
    0.90    
)

mutable struct ACFLOW_PStochOM
    ntry  :: I64
    nstep :: I64
    nbox  :: I64
    sbox  :: F64
    wbox  :: F64
    norm  :: F64
end

PStochOM = ACFLOW_PStochOM(
    2000,
    1000,
    100,
    0.005,
    0.02,
    -1.0
)
