#
# Project : Camellia
# Source  : types.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
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
    ACFLOW_PMaxEnt
"""
mutable struct ACFLOW_PMaxEnt
    method :: String
    stype  :: String
    nalph  :: I64
    alpha  :: F64
    ratio  :: F64
    blur   :: F64
end

"""
    ACFLOW_PBarRat
"""
mutable struct ACFLOW_PBarRat
    atype   :: String
    denoise :: String
    epsilon :: F64
    pcut    :: F64
    eta     :: F64
end

"""
    ACFLOW_PNevanAC
"""
mutable struct ACFLOW_PNevanAC
    pick  :: Bool
    hardy :: Bool
    hmax  :: I64
    alpha :: F64
    eta   :: F64
end

"""
    ACFLOW_PStochAC
"""
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

"""
    ACFLOW_PStochSK
"""
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

"""
    ACFLOW_PStochOM
"""
mutable struct ACFLOW_PStochOM
    ntry  :: I64
    nstep :: I64
    nbox  :: I64
    sbox  :: F64
    wbox  :: F64
    norm  :: F64
end

"""
    ACFLOW_PStochPX
"""
mutable struct ACFLOW_PStochPX
    method :: String
    nfine  :: I64
    npole  :: I64
    ntry   :: I64
    nstep  :: I64
    theta  :: F64
    eta    :: F64
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

"""
    PMaxEnt
"""
PMaxEnt = ACFLOW_PMaxEnt(
    "chi2kink",
    "sj",
    12,
    1e9,
    10.0,
    -1.0
)

"""
    PBarRat
"""
PBarRat = ACFLOW_PBarRat(
    "cont",
    "prony",
    1e-10,
    1e-3,
    1e-2
)

"""
    PNevanAC
"""
PNevanAC = ACFLOW_PNevanAC(
    true,
    true,
    50,
    1e-4,
    1e-2
)

"""
    PStochAC
"""
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

"""
    PStochSK
"""
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

"""
    PStochOM
"""
PStochOM = ACFLOW_PStochOM(
    2000,
    1000,
    100,
    0.005,
    0.02,
    -1.0
)

"""
    PStochPX
"""
PStochPX = ACFLOW_PStochPX(
    "mean",
    100000,
    200,
    1000,
    1000000,
    1e+6,
    1e-4
)

"""
    _struct_to_dict(s::ACFLOW_PBASE)
"""
function _struct_to_dict(s::ACFLOW_PBASE)
    return Dict{String,Any}(
        "finput"  => s.finput,
        "solver"  => s.solver,
        "ktype"   => s.ktype,
        "mtype"   => s.mtype,
        "grid"    => s.grid,
        "mesh"    => s.mesh,
        "ngrid"   => s.ngrid,
        "nmesh"   => s.nmesh,
        "wmax"    => s.wmax,
        "wmin"    => s.wmin,
        "beta"    => s.beta,
        "offdiag" => s.offdiag,
        "fwrite"  => s.fwrite
    )
end

"""
    _struct_to_dict(s::ACFLOW_PMaxEnt)
"""
function _struct_to_dict(s::ACFLOW_PMaxEnt)
    return Dict{String,Any}(
        "method" => s.method,
        "stype"  => s.stype,
        "nalph"  => s.nalph,
        "alpha"  => s.alpha,
        "ratio"  => s.ratio,
        "blur"   => s.blur
    )
end

"""
    _struct_to_dict(s::ACFLOW_PBarRat)
"""
function _struct_to_dict(s::ACFLOW_PBarRat)
    return Dict{String,Any}(
        "atype"   => "cont",
        "denoise" => "prony",
        "epsilon" => 1e-10,
        "pcut"    => 1e-3,
        "eta"     => 1e-2,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PNevanAC)
"""
function _struct_to_dict(s::ACFLOW_PNevanAC)
    return Dict{String,Any}(
        "pick"    => true,
        "hardy"   => true,
        "hmax"    => 50,
        "alpha"   => 1e-4,
        "eta"     => 1e-2,        
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochAC)
"""
function _struct_to_dict(s::ACFLOW_PStochAC)
    return Dict{String,Any}(
        "nfine"   => 10000,
        "ngamm"   => 512,
        "nwarm"   => 4000,
        "nstep"   => 4000000,
        "ndump"   => 40000,
        "nalph"   => 20,
        "alpha"   => 1.00,
        "ratio"   => 1.20,        
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochSK)
"""
function _struct_to_dict(s::ACFLOW_PStochSK)
    return Dict{String,Any}(
        "method"  => "chi2min",
        "nfine"   => 100000,
        "ngamm"   => 1000,
        "nwarm"   => 1000,
        "nstep"   => 20000,
        "ndump"   => 200,
        "retry"   => 10,
        "theta"   => 1e+6,
        "ratio"   => 0.90,        
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochOM)
"""
function _struct_to_dict(s::ACFLOW_PStochOM)
    return Dict{String,Any}(
        "ntry"    => 2000,
        "nstep"   => 1000,
        "nbox"    => 100,
        "sbox"    => 0.005,
        "wbox"    => 0.02,
        "norm"    => -1.0,        
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochPX)
"""
function _struct_to_dict(s::ACFLOW_PStochPX)
    return Dict{String,Any}(
        "method"  => "mean",
        "nfine"   => 100000,
        "npole"   => 200,
        "ntry"    => 1000,
        "nstep"   => 1000000,
        "theta"   => 1e+6,
        "eta"     => 1e-4,        
    )
end

"""
    _build_acflow_dict()
"""
function _build_acflow_dict()
    @cswitch PBASE.solver begin

        @case "MaxEnt"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "MaxEnt" => _struct_to_dict(PMaxEnt)
            )
            break

        @case "BarRat"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "BarRat" => _struct_to_dict(PBarRat)
            )
            break

        @case "NevanAC"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "NevanAC" => _struct_to_dict(PNevanAC)
            )
            break

        @case "StochAC"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "StochAC" => _struct_to_dict(PStochAC)
            )
            break

        @case "StochSK"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "StochSK" => _struct_to_dict(PStochSK)
            )
            break

        @case "StochOM"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "StochOM" => _struct_to_dict(PStochOM)
            )
            break

        @case "StochPX"
            return Dict(
                "BASE" => _struct_to_dict(PBASE),
                "StochPX" => _struct_to_dict(PStochPX)
            )
            break

        @default
            sorry()
            break

    end
end

"""
    _dict_to_toml(d::Dict)
"""
function _dict_to_toml(d::Dict)
    io = IOBuffer()
    TOML.print(io,d)
    return String(take!(io))
end
