#
# Project : Camellia
# Source  : types.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/22
#

#=
### *Customized Structs* : *Active Window*
=#

"""
    CURRENT_WINDOW

A struct used to keep the name of the current (activate) window.

### Members
* name -> Name of the current window.

See also: [`CWIN`](@ref).
"""
mutable struct CURRENT_WINDOW
    name :: String
end

"""
    CWIN

An instance for the `CURRENT_WINDOW` struct.

See also: [`CURRENT_WINDOW`](@ref).
"""
CWIN = CURRENT_WINDOW(
    "nothing"
)

#=
### *Customized Structs* : *Menu Flags*
=#

"""
    MenuFlags

A struct used to track the status of all the menu items. The renderloop
should respond the mouse events according to this struct.

The meun items are created at `src/menu.jl`.

### Members
* F_SAVE     -> File | Save.
* F_EXIT     -> File | Exit.
* E_ZEN      -> Edit | Integrated Package | Zen.
* E_DYSON    -> Edit | Quantum Many-Body Theory Engines | Dyson.
* E_DFERMION -> Edit | Quantum Many-Body Theory Engines | DFermion.
* E_CTSEG    -> Edit | Quantum Impurity Solvers | iQIST | ctseg.
* E_CTHYB    -> Edit | Quantum Impurity Solvers | iQIST | cthyb.
* E_ATOMIC   -> Edit | Quantum Impurity Solvers | iQIST | atomic.
* E_ACFLOW   -> Edit | Analytic Continuation Tools | ACFlow.
* E_ACTEST   -> Edit | Analytic Continuation Tools | ACTest.
* S_CLASSIC  -> Style | Classic.
* S_DARK     -> Style | Dark.
* S_LIGHT    -> Style | Light.
* H_ZEN      -> Help | Documentation | Zen.
* H_DYSON    -> Help | Documentation | Dyson.
* H_DFERMION -> Help | Documentation | DFermion.
* H_IQIST    -> Help | Documentation | iQIST.
* H_ACFLOW   -> Help | Documentation | ACFlow.
* H_ACTEST   -> Help | Documentation | ACTest.
* H_ZENGUI   -> Help | User's manual.
* H_ABOUT    -> Help | About ZenGui.

See also: [`FMENU`](@ref), [`zen_run`](@ref).
"""
mutable struct MenuFlags
    F_SAVE     :: Bool
    F_EXIT     :: Bool
    #
    E_ZEN      :: Bool
    E_DYSON    :: Bool
    E_DFERMION :: Bool
    E_CTSEG    :: Bool
    E_CTHYB    :: Bool
    E_ATOMIC   :: Bool
    E_ACFLOW   :: Bool
    E_ACTEST   :: Bool
    #
    S_CLASSIC  :: Bool
    S_DARK     :: Bool
    S_LIGHT    :: Bool
    #
    H_ZEN      :: Bool
    H_DYSON    :: Bool
    H_DFERMION :: Bool
    H_IQIST    :: Bool
    H_ACFLOW   :: Bool
    H_ACTEST   :: Bool
    H_ZENGUI   :: Bool
    H_ABOUT    :: Bool
end

"""
    FMENU

An instance for the `MenuFlags` struct. Initially, all members are set
to be false.

See also: [`MenuFlags`](@ref).
"""
FMENU = MenuFlags(
    false, # F_SAVE
    false, # F_EXIT
    false, # E_ZEN
    false, # E_DYSON
    false, # E_DFERMION
    false, # E_CTSEG
    false, # E_CTHYB
    false, # E_ATOMIC
    false, # E_ACFLOW
    false, # E_ACTEST
    false, # S_CLASSIC
    false, # S_DARK
    false, # S_LIGHT
    false, # H_ZEN
    false, # H_DYSON
    false, # H_DFERMION
    false, # H_IQIST
    false, # H_ACFLOW
    false, # H_ACTEST
    false, # H_ZENGUI
    false  # H_ABOUT
)

#=
### *Customized Structs* : *Zen Package*
=#

#=
*Remarks* :

The official configuration file for the Zen package is `case.toml`. It
includes `[case]`, `[dft]`, `[dmft]`, `[impurity]`, and `[solver]` blocks.
=#

"""
    ZEN_PCASE

This struct represents the `[case]` block in the `case.toml` file.
"""
mutable struct ZEN_PCASE
    case :: String
end

"""
    ZEN_PDFT

This struct represents the `[dft]` block in the `case.toml` file.
"""
mutable struct ZEN_PDFT
    engine   :: String
    projtype :: String
    smear    :: String
    kmesh    :: String
    magmom   :: String
    ncycle   :: I64
    lsymm    :: Bool
    lspins   :: Bool
    lspinorb :: Bool
    lproj    :: Bool
    sproj    :: Array
    window   :: Array
end

"""
    ZEN_PDMFT

This struct represents the `[dmft]` block in the `case.toml` file.
"""
mutable struct ZEN_PDMFT
    mode   :: I64
    axis   :: I64
    niter  :: I64
    nmesh  :: I64
    dcount :: String
    beta   :: F64
    mixer  :: F64
    mc     :: F64
    cc     :: F64
    ec     :: F64
    sc     :: F64
    lfermi :: Bool
end

"""
    ZEN_PIMPURITY

This struct represents the `[impurity]` block in the `case.toml` file.
"""
mutable struct ZEN_PIMPURITY
    nsite :: I64
    atoms :: Array
    equiv :: Array
    shell :: Array
    ising :: Array
    occup :: Array
    upara :: Array
    jpara :: Array
    lpara :: Array
end

"""
    ZEN_PSOLVER

This struct represents the `[solver]` block in the `case.toml` file.
"""
mutable struct ZEN_PSOLVER
    engine :: String
    ncycle :: I64
    params :: Array
end

"""
    PCASE

An instance for the `ZEN_PCASE` struct.

See also: [`ZEN_PCASE`](@ref).
"""
PCASE = ZEN_PCASE(
    "SrVO3" # case
)

"""
    PDFT

An instance for the `ZEN_PDFT` struct.

See also: [`ZEN_PDFT`](@ref).
"""
PDFT = ZEN_PDFT(
    "vasp",         # engine
    "plo",          # projtype
    "tetra",        # smear
    "medium",       # kmesh
    "1.0",          # magmom
    8,              # ncycle
    false,          # lsymm
    false,          # lspins
    false,          # lspinorb
    true,           # lproj
    ["2 : d : Pr"], # sproj
    [-1.4, 6.0]     # window
)

"""
    PDMFT

An instance for the `ZEN_PDMFT` struct.

See also: [`ZEN_PDMFT`](@ref).
"""
PDMFT = ZEN_PDMFT(
    1,      # mode
    1,      # axis
    60,     # niter
    8193,   # nmesh
    "fll2", # dcount
    40.0,   # beta
    0.1,    # mixer
    1.0e-4, # mc
    1.0e-6, # cc
    1.0e-4, # ec
    1.0e-4, # sc
    true    # lfermi
)

"""
    PIMPURITY

An instance for the `ZEN_PIMPURITY` struct.

See also: [`ZEN_PIMPURITY`](@ref).
"""
PIMPURITY = ZEN_PIMPURITY(
    1,         # nsite
    ["V : 2"], # atoms
    [1],       # equiv
    ["d"],     # shell
    ["ising"], # ising
    [1.0],     # occup
    [4.0],     # upara
    [0.7],     # jpara
    [0.0]      # lpara
)

"""
    PSOLVER

An instance for the `ZEN_PSOLVER` struct.

See also: [`ZEN_PSOLVER`](@ref).
"""
PSOLVER = ZEN_PSOLVER(
    "ctseg", # engine
    2,       # ncycle
    ["isbnd = 2", "isort = 2", "nsweep = 100000000"] # params
)

"""
    _struct_to_dict(s::ZEN_PCASE)

Convert a struct to an ordered dictionary (for `ZEN_PCASE`).

See [`ZEN_PCASE`](@ref).
"""
function _struct_to_dict(s::ZEN_PCASE)
    return OrderedDict{String,Any}(
        "case" => s.case,
    )
end

"""
    _struct_to_dict(s::ZEN_PDFT)

Convert a struct to an ordered dictionary (for `ZEN_PDFT`).

See [`ZEN_PDFT`](@ref).
"""
function _struct_to_dict(s::ZEN_PDFT)
    return OrderedDict{String,Any}(
        "engine"   => s.engine,
        "projtype" => s.projtype,
        "smear"    => s.smear,
        "kmesh"    => s.kmesh,
        "magmom"   => s.magmom,
        "ncycle"   => s.ncycle,
        "lsymm"    => s.lsymm,
        "lspins"   => s.lspins,
        "lspinorb" => s.lspinorb,
        "lproj"    => s.lproj,
        "sproj"    => s.sproj,
        "window"   => s.window,
    )
end

"""
    _struct_to_dict(s::ZEN_PDMFT)

Convert a struct to an ordered dictionary (for `ZEN_PDMFT`).

See [`ZEN_PDMFT`](@ref).
"""
function _struct_to_dict(s::ZEN_PDMFT)
    return OrderedDict{String,Any}(
        "mode"     => s.mode,
        "axis"     => s.axis,
        "niter"    => s.niter,
        "nmesh"    => s.nmesh,
        "dcount"   => s.dcount,
        "beta"     => s.beta,
        "mixer"    => s.mixer,
        "mc"       => s.mc,
        "cc"       => s.cc,
        "ec"       => s.ec,
        "sc"       => s.sc,
        "lfermi"   => s.lfermi,
    )
end

"""
    _struct_to_dict(s::ZEN_PIMPURITY)

Convert a struct to an ordered dictionary (for `ZEN_PIMPURITY`).

See [`ZEN_PIMPURITY`](@ref).
"""
function _struct_to_dict(s::ZEN_PIMPURITY)
    return OrderedDict{String,Any}(
        "nsite"    => s.nsite,
        "atoms"    => s.atoms,
        "equiv"    => s.equiv,
        "shell"    => s.shell,
        "ising"    => s.ising,
        "occup"    => s.occup,
        "upara"    => s.upara,
        "jpara"    => s.jpara,
        "lpara"    => s.lpara,
    )
end

"""
    _struct_to_dict(s::ZEN_PSOLVER)

Convert a struct to an ordered dictionary (for `ZEN_PSOLVER`).

See [`ZEN_PSOLVER`](@ref).
"""
function _struct_to_dict(s::ZEN_PSOLVER)
    return OrderedDict{String,Any}(
        "engine"   => s.engine,
        "ncycle"   => s.ncycle,
        "params"   => s.params,
    )
end

"""
    _build_zen_dict()
"""
function _build_zen_dict()
    return OrderedDict{String,Any}(
        "case" => _struct_to_dict(PCASE)["case"],
        "dft" => _struct_to_dict(PDFT),
        "dmft" => _struct_to_dict(PDMFT),
        "impurity" => _struct_to_dict(PIMPURITY),
        "solver" => _struct_to_dict(PSOLVER)
    )
end

#=
### *Customized Structs* : *Dyson Code*
=#

"""
    DYSON_PDYSON
"""
mutable struct DYSON_PDYSON
    task   :: I64
    axis   :: I64
    beta   :: F64
    mc     :: F64
    lfermi :: String
    ltetra :: String
end

"""
    _DYSON
"""
_DYSON = Set{String}()

"""
    PDYSON
"""
PDYSON = DYSON_PDYSON(
    1,
    1,
    8.0,
    0.0001,
    ".true.",
    ".true."
)

"""
    _struct_to_dict(s::DYSON_PDYSON)
"""
function _struct_to_dict(s::DYSON_PDYSON)
    OD = OrderedDict{String,Any}()
    #
    "task"   ∈ _DYSON && ( OD["task"]   = s.task   )
    "axis"   ∈ _DYSON && ( OD["axis"]   = s.axis   )
    "beta"   ∈ _DYSON && ( OD["beta"]   = s.beta   )
    "mc"     ∈ _DYSON && ( OD["mc"]     = s.mc     )
    "lfermi" ∈ _DYSON && ( OD["lfermi"] = s.lfermi )
    "ltetra" ∈ _DYSON && ( OD["ltetra"] = s.ltetra )
    #
    return OD
end

"""
    _build_dyson_dict()
"""
function _build_dyson_dict()
    return _struct_to_dict(PDYSON)
end

#=
### *Customized Structs* : *DFermion Code*
=#

"""
    DFERMION_PDFERMION
"""
mutable struct DFERMION_PDFERMION
    isdia :: I64 # Cycle
    nband :: I64 # Model
    nspin :: I64 # Model
    norbs :: I64 # Model
    nffrq :: I64 # Dimension
    nbfrq :: I64 # Dimension
    nkpts :: I64 # K-mesh
    nkp_x :: I64 # K-mesh
    nkp_y :: I64 # K-mesh
    nkp_z :: I64 # K-mesh
    ndfit :: I64 # Cycle
    nbsit :: I64 # Cycle
    mune  :: F64 # Model
    beta  :: F64 # Model
    part  :: F64 # Model
    dfmix :: F64 # Cycle
    bsmix :: F64 # Cycle
end

"""
    _DFERMION
"""
_DFERMION = Set{String}()

"""
    PDFERMION
"""
PDFERMION = DFERMION_PDFERMION(
    2,
    1,
    2,
    2,
    16,
    7,
    64,
    8,
    8,
    8,
    10,
    10,
    0.0,
    1.0,
    1.0,
    1.0,
    0.7
)

"""
    _struct_to_dict(s::DFERMION_PDFERMION)
"""
function _struct_to_dict(s::DFERMION_PDFERMION)
    OD = OrderedDict{String,Any}()
    #
    "isdia" ∈ _DFERMION && ( OD["isdia"] = s.isdia )
    "nband" ∈ _DFERMION && ( OD["nband"] = s.nband )
    "nspin" ∈ _DFERMION && ( OD["nspin"] = s.nspin )
    "norbs" ∈ _DFERMION && ( OD["norbs"] = s.norbs )
    "nffrq" ∈ _DFERMION && ( OD["nffrq"] = s.nffrq )
    "nbfrq" ∈ _DFERMION && ( OD["nbfrq"] = s.nbfrq )
    "nkpts" ∈ _DFERMION && ( OD["nkpts"] = s.nkpts )
    "nkp_x" ∈ _DFERMION && ( OD["nkp_x"] = s.nkp_x )
    "nkp_y" ∈ _DFERMION && ( OD["nkp_y"] = s.nkp_y )
    "nkp_z" ∈ _DFERMION && ( OD["nkp_z"] = s.nkp_z )
    "ndfit" ∈ _DFERMION && ( OD["ndfit"] = s.ndfit )
    "nbsit" ∈ _DFERMION && ( OD["nbsit"] = s.nbsit )
    "mune"  ∈ _DFERMION && ( OD["mune"]  = s.mune  )
    "beta"  ∈ _DFERMION && ( OD["beta"]  = s.beta  )
    "part"  ∈ _DFERMION && ( OD["part"]  = s.part  )
    "dfmix" ∈ _DFERMION && ( OD["dfmix"] = s.dfmix )
    "bsmix" ∈ _DFERMION && ( OD["bsmix"] = s.bsmix )
    #
    return OD
end

"""
    _build_dfermion_dict()
"""
function _build_dfermion_dict()
    return _struct_to_dict(PDFERMION)
end

#=
### *Customized Structs* : *iQIST Package*
=#

"""
    IQIST_PCTSEG
"""
mutable struct IQIST_PCTSEG
    isscf  :: I64 # Cycle
    isscr  :: I64 # Model
    isbnd  :: I64 # Symmetry
    isspn  :: I64 # Symmetry
    iswor  :: I64 # Measurement
    isort  :: I64 # Representation
    isobs  :: I64 # Measurement
    issus  :: I64 # Measurement
    isvrt  :: I64 # Measurement
    nband  :: I64 # Model
    nspin  :: I64 # Model
    norbs  :: I64 # Model
    ncfgs  :: I64 # Model
    niter  :: I64 # Cycle
    lemax  :: I64 # Representation
    legrd  :: I64 # Representation
    svmax  :: I64 # Representation
    svgrd  :: I64 # Representation
    mkink  :: I64 # Monte Carlo
    mfreq  :: I64 # Dimension
    nffrq  :: I64 # Dimension
    nbfrq  :: I64 # Dimension
    nfreq  :: I64 # Dimension
    ntime  :: I64 # Dimension
    nflip  :: I64 # Monte Carlo
    ntherm :: I64 # Monte Carlo
    nsweep :: I64 # Monte Carlo
    nwrite :: I64 # Monte Carlo
    nclean :: I64 # Monte Carlo
    nmonte :: I64 # Monte Carlo
    ncarlo :: I64 # Monte Carlo
    Uc     :: F64 # Model
    Jz     :: F64 # Model
    lc     :: F64 # Model
    wc     :: F64 # Model
    mune   :: F64 # Model
    beta   :: F64 # Model
    part   :: F64 # Model
    alpha  :: F64 # Cycle
end

"""
    IQIST_PCTHYB
"""
mutable struct IQIST_PCTHYB
end

"""
    IQIST_PATOMIC
"""
mutable struct IQIST_PATOMIC
    ibasis :: I64 # Natural eigenbasis
    ictqmc :: I64 # Algorithm
    icu    :: I64 # Interaction
    icf    :: I64 # Natural eigenbasis
    isoc   :: I64 # Natural eigenbasis
    nband  :: I64 # Model
    nspin  :: I64 # Model
    norbs  :: I64 # Model
    ncfgs  :: I64 # Model
    nmini  :: I64 # Algorithm
    nmaxi  :: I64 # Algorithm
    Uc     :: F64 # Interaction
    Uv     :: F64 # Interaction
    Jz     :: F64 # Interaction
    Js     :: F64 # Interaction
    Jp     :: F64 # Interaction
    Ud     :: F64 # Interaction
    Jh     :: F64 # Interaction
    mune   :: F64 # Natural eigenbasis
    lambda :: F64 # Natural eigenbasis
end

"""
    _CTSEG
"""
_CTSEG = Set{String}()

"""
    _CTHYB
"""
_CTHYB = Set{String}()

"""
    _ATOMIC
"""
_ATOMIC = Set{String}()

"""
    PCTSEG
"""
PCTSEG = IQIST_PCTSEG(
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    4,
    20,
    32,
    20001,
    32,
    2001,
    1024,
    8193,
    32,
    8,
    128,
    1024,
    20000,
    200000,
    20000000,
    2000000,
    100000,
    10,
    10,
    4.0,
    0.0,
    1.0,
    1.0,
    2.0,
    8.0,
    0.5,
    0.7
)

"""
    PCTHYB
"""
PCTHYB = IQIST_PCTHYB()

"""
    PATOMIC
"""
PATOMIC = IQIST_PATOMIC(
    1,
    1,
    1,
    0,
    0,
    1,
    2,
    2,
    4,
    0,
    2,
    2.0,
    2.0,
    0.0,
    0.0,
    0.0,
    2.0,
    0.0,
    0.0,
    0.0
)

"""
    _struct_to_dict(s::IQIST_PCTSEG)
"""
function _struct_to_dict(s::IQIST_PCTSEG)
    OD = OrderedDict{String,Any}()
    #
    "isscf"  ∈ _CTSEG && ( OD["isscf"]  = s.isscf  )
    "isscr"  ∈ _CTSEG && ( OD["isscr"]  = s.isscr  )
    "isbnd"  ∈ _CTSEG && ( OD["isbnd"]  = s.isbnd  )
    "isspn"  ∈ _CTSEG && ( OD["isspn"]  = s.isspn  )
    "iswor"  ∈ _CTSEG && ( OD["iswor"]  = s.iswor  )
    "isort"  ∈ _CTSEG && ( OD["isort"]  = s.isort  )
    "isobs"  ∈ _CTSEG && ( OD["isobs"]  = s.isobs  )
    "issus"  ∈ _CTSEG && ( OD["issus"]  = s.issus  )
    "isvrt"  ∈ _CTSEG && ( OD["isvrt"]  = s.isvrt  )
    "nband"  ∈ _CTSEG && ( OD["nband"]  = s.nband  )
    "nspin"  ∈ _CTSEG && ( OD["nspin"]  = s.nspin  )
    "norbs"  ∈ _CTSEG && ( OD["norbs"]  = s.norbs  )
    "ncfgs"  ∈ _CTSEG && ( OD["ncfgs"]  = s.ncfgs  )
    "niter"  ∈ _CTSEG && ( OD["niter"]  = s.niter  )
    "lemax"  ∈ _CTSEG && ( OD["lemax"]  = s.lemax  )
    "legrd"  ∈ _CTSEG && ( OD["legrd"]  = s.legrd  )
    "svmax"  ∈ _CTSEG && ( OD["svmax"]  = s.svmax  )
    "svgrd"  ∈ _CTSEG && ( OD["svgrd"]  = s.svgrd  )
    "mkink"  ∈ _CTSEG && ( OD["mkink"]  = s.mkink  )
    "mfreq"  ∈ _CTSEG && ( OD["mfreq"]  = s.mfreq  )
    "nffrq"  ∈ _CTSEG && ( OD["nffrq"]  = s.nffrq  )
    "nbfrq"  ∈ _CTSEG && ( OD["nbfrq"]  = s.nbfrq  )
    "nfreq"  ∈ _CTSEG && ( OD["nfreq"]  = s.nfreq  )
    "ntime"  ∈ _CTSEG && ( OD["ntime"]  = s.ntime  )
    "nflip"  ∈ _CTSEG && ( OD["nflip"]  = s.nflip  )
    "ntherm" ∈ _CTSEG && ( OD["ntherm"] = s.ntherm )
    "nsweep" ∈ _CTSEG && ( OD["nsweep"] = s.nsweep )
    "nwrite" ∈ _CTSEG && ( OD["nwrite"] = s.nwrite )
    "nclean" ∈ _CTSEG && ( OD["nclean"] = s.nclean )
    "nmonte" ∈ _CTSEG && ( OD["nmonte"] = s.nmonte )
    "ncarlo" ∈ _CTSEG && ( OD["ncarlo"] = s.ncarlo )
    "Uc"     ∈ _CTSEG && ( OD["Uc"]     = s.Uc     )
    "Jz"     ∈ _CTSEG && ( OD["Jz"]     = s.Jz     )
    "lc"     ∈ _CTSEG && ( OD["lc"]     = s.lc     )
    "wc"     ∈ _CTSEG && ( OD["wc"]     = s.wc     )
    "mune"   ∈ _CTSEG && ( OD["mune"]   = s.mune   )
    "beta"   ∈ _CTSEG && ( OD["beta"]   = s.beta   )
    "part"   ∈ _CTSEG && ( OD["part"]   = s.part   )
    "alpha"  ∈ _CTSEG && ( OD["alpha"]  = s.alpha  )
    #
    return OD
end

"""
    _struct_to_dict(s::IQIST_PCTHYB)
"""
function _struct_to_dict(s::IQIST_PCTHYB)
    return OrderedDict{String,Any}(
        "key" => "value",
    )
end

"""
    _struct_to_dict(s::IQIST_PATOMIC)
"""
function _struct_to_dict(s::IQIST_PATOMIC)
    OD = OrderedDict{String,Any}()
    #
    "ibasis" ∈ _ATOMIC && ( OD["ibasis"] = s.ibasis )
    "ictqmc" ∈ _ATOMIC && ( OD["ictqmc"] = s.ictqmc )
    "icu"    ∈ _ATOMIC && ( OD["icu"]    = s.icu    )
    "icf"    ∈ _ATOMIC && ( OD["icf"]    = s.icf    )
    "isoc"   ∈ _ATOMIC && ( OD["isoc"]   = s.isoc   )
    "nband"  ∈ _ATOMIC && ( OD["nband"]  = s.nband  )
    "nspin"  ∈ _ATOMIC && ( OD["nspin"]  = s.nspin  )
    "norbs"  ∈ _ATOMIC && ( OD["norbs"]  = s.norbs  )
    "ncfgs"  ∈ _ATOMIC && ( OD["ncfgs"]  = s.ncfgs  )
    "nmini"  ∈ _ATOMIC && ( OD["nmini"]  = s.nmini  )
    "nmaxi"  ∈ _ATOMIC && ( OD["nmaxi"]  = s.nmaxi  )
    "Uc"     ∈ _ATOMIC && ( OD["Uc"]     = s.Uc     )
    "Uv"     ∈ _ATOMIC && ( OD["Uv"]     = s.Uv     )
    "Jz"     ∈ _ATOMIC && ( OD["Jz"]     = s.Jz     )
    "Js"     ∈ _ATOMIC && ( OD["Js"]     = s.Js     )
    "Jp"     ∈ _ATOMIC && ( OD["Jp"]     = s.Jp     )
    "Ud"     ∈ _ATOMIC && ( OD["Ud"]     = s.Ud     )
    "Jh"     ∈ _ATOMIC && ( OD["Jh"]     = s.Jh     )
    "mune"   ∈ _ATOMIC && ( OD["mune"]   = s.mune   )
    "lambda" ∈ _ATOMIC && ( OD["lambda"] = s.lambda )
    #
    return OD
end

"""
    _build_iqist_dict()
"""
function _build_iqist_dict(solver::String)
    @cswitch solver begin

        @case "ctseg"
            return _struct_to_dict(PCTSEG)
            break

        @case "cthyb"
            return _struct_to_dict(PCTHYB)
            break

        @case "atomic"
            return _struct_to_dict(PATOMIC)
            break

        @default
            sorry()
            break

    end
end

#=
### *Customized Structs* : *ACFlow Toolkit*
=#

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
    return OrderedDict{String,Any}(
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
        "fwrite"  => s.fwrite,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PMaxEnt)
"""
function _struct_to_dict(s::ACFLOW_PMaxEnt)
    return OrderedDict{String,Any}(
        "method" => s.method,
        "stype"  => s.stype,
        "nalph"  => s.nalph,
        "alpha"  => s.alpha,
        "ratio"  => s.ratio,
        "blur"   => s.blur,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PBarRat)
"""
function _struct_to_dict(s::ACFLOW_PBarRat)
    return OrderedDict{String,Any}(
        "atype"   => s.atype,
        "denoise" => s.denoise,
        "epsilon" => s.epsilon,
        "pcut"    => s.pcut,
        "eta"     => s.eta,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PNevanAC)
"""
function _struct_to_dict(s::ACFLOW_PNevanAC)
    return OrderedDict{String,Any}(
        "pick"    => s.pick,
        "hardy"   => s.hardy,
        "hmax"    => s.hmax,
        "alpha"   => s.alpha,
        "eta"     => s.eta,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochAC)
"""
function _struct_to_dict(s::ACFLOW_PStochAC)
    return OrderedDict{String,Any}(
        "nfine"   => s.nfine,
        "ngamm"   => s.ngamm,
        "nwarm"   => s.nwarm,
        "nstep"   => s.nstep,
        "ndump"   => s.ndump,
        "nalph"   => s.nalph,
        "alpha"   => s.alpha,
        "ratio"   => s.ratio,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochSK)
"""
function _struct_to_dict(s::ACFLOW_PStochSK)
    return OrderedDict{String,Any}(
        "method"  => s.method,
        "nfine"   => s.nfine,
        "ngamm"   => s.ngamm,
        "nwarm"   => s.nwarm,
        "nstep"   => s.nstep,
        "ndump"   => s.ndump,
        "retry"   => s.retry,
        "theta"   => s.theta,
        "ratio"   => s.ratio,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochOM)
"""
function _struct_to_dict(s::ACFLOW_PStochOM)
    return OrderedDict{String,Any}(
        "ntry"    => s.ntry,
        "nstep"   => s.nstep,
        "nbox"    => s.nbox,
        "sbox"    => s.sbox,
        "wbox"    => s.wbox,
        "norm"    => s.norm,
    )
end

"""
    _struct_to_dict(s::ACFLOW_PStochPX)
"""
function _struct_to_dict(s::ACFLOW_PStochPX)
    return OrderedDict{String,Any}(
        "method"  => s.method,
        "nfine"   => s.nfine,
        "npole"   => s.npole,
        "ntry"    => s.ntry,
        "nstep"   => s.nstep,
        "theta"   => s.theta,
        "eta"     => s.eta,
    )
end

"""
    _build_acflow_dict()
"""
function _build_acflow_dict()
    @cswitch PBASE.solver begin

        @case "MaxEnt"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "MaxEnt" => _struct_to_dict(PMaxEnt)
            )
            break

        @case "BarRat"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "BarRat" => _struct_to_dict(PBarRat)
            )
            break

        @case "NevanAC"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "NevanAC" => _struct_to_dict(PNevanAC)
            )
            break

        @case "StochAC"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "StochAC" => _struct_to_dict(PStochAC)
            )
            break

        @case "StochSK"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "StochSK" => _struct_to_dict(PStochSK)
            )
            break

        @case "StochOM"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "StochOM" => _struct_to_dict(PStochOM)
            )
            break

        @case "StochPX"
            return OrderedDict{String,Any}(
                "BASE" => _struct_to_dict(PBASE),
                "StochPX" => _struct_to_dict(PStochPX)
            )
            break

        @default
            sorry()
            break

    end
end

#=
### *Customized Structs* : *ACTest Toolkit*
=#

"""
    ACTEST_PTEST
"""
mutable struct ACTEST_PTEST
    solver  :: String
    ptype   :: String
    ktype   :: String
    grid    :: String
    mesh    :: String
    ngrid   :: I64
    nmesh   :: I64
    ntest   :: I64
    wmax    :: F64
    wmin    :: F64
    pmax    :: F64
    pmin    :: F64
    beta    :: F64
    noise   :: F64
    offdiag :: Bool
    lpeak   :: Array
end

"""
    PTEST
"""
PTEST = ACTEST_PTEST(
    "MaxEnt",
    "gauss",
    "fermi",
    "ffreq",
    "linear",
    10,
    501,
    100,
    5.0,
    -5.0,
    4.0,
    -4.0,
    10.0,
    1.0e-6,
    false,
    [1,2,3]
)

"""
    _struct_to_dict(s::ACTEST_PTEST)
"""
function _struct_to_dict(s::ACTEST_PTEST)
    return OrderedDict{String,Any}(
        "solver"  => s.solver,
        "ptype"   => s.ptype,
        "ktype"   => s.ktype,
        "grid"    => s.grid,
        "mesh"    => s.mesh,
        "ngrid"   => s.ngrid,
        "nmesh"   => s.nmesh,
        "ntest"   => s.ntest,
        "wmax"    => s.wmax,
        "wmin"    => s.wmin,
        "pmax"    => s.pmax,
        "pmin"    => s.pmin,
        "beta"    => s.beta,
        "noise"   => s.noise,
        "offdiag" => s.offdiag,
        "lpeak"   => s.lpeak,
    )
end

"""
    _build_actest_dict()
"""
function _build_actest_dict()
    @cswitch PTEST.solver begin

        @case "MaxEnt"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PMaxEnt)
            )
            break

        @case "BarRat"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PBarRat)
            )
            break

        @case "NevanAC"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PNevanAC)
            )
            break

        @case "StochAC"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PStochAC)
            )
            break

        @case "StochSK"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PStochSK)
            )
            break

        @case "StochOM"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PStochOM)
            )
            break

        @case "StochPX"
            return OrderedDict{String,Any}(
                "Test" => _struct_to_dict(PTEST),
                "Solver" => _struct_to_dict(PStochPX)
            )
            break

        @default
            sorry()
            break

    end
end

#=
### *Utility*
=#

"""
    _dict_to_toml(d::AbstractDict)
"""
function _dict_to_toml(d::AbstractDict)
    io = IOBuffer()
    TOML.print(io,d)
    return String(take!(io))
end

"""
    _dict_to_string(d::AbstractDict)
"""
function _dict_to_string(d::AbstractDict)
    io = IOBuffer()
    for (key, value) in d
        println(io, "$key = $value")
    end
    return String(take!(io))
end
