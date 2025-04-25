# Library

## Contents

```@contents
Pages = ["library.md"]
Depth = 2
```

## Index

```@index
Pages = ["library.md"]
```

## Modules

```@docs
ZenGui
```

## Numerical Types

```@docs
I32
I64
API
F32
F64
APF
C32
C64
APC
R32
R64
APR
N32
N64
APN
```

## String Constants

```@docs
__LIBNAME__
__VERSION__
__RELEASE__
__AUTHORS__
```

## Utilities

```@docs
authors
_struct_to_dict
```

## Structs: Menu

```docs
FMENU
```

## Widgets: Menu

```@docs
create_menu
set_menu_file
set_menu_edit
set_menu_style
set_menu_help
handle_menu_dark
handle_menu_classic
handle_menu_acflow
```

## Structs: Zen

```@docs
ZEN_PDMFT
ZEN_PSOLVER
PCASE
PDFT
PDMFT
PIMPURITY
PSOLVER
```

## Widgets: Zen

```@docs
create_app_zen
_zen_case_block
_zen_dft_block
_zen_main_block
_zen_dmft_block
_zen_solver_block
```

## Structs: Dyson

```@docs
_DYSON
```

## Widgets: Dyson

```@docs
_dyson_top_block
_dyson_main_block
_build_dyson_dict
```

## Structs: DFermion

```@docs
PDFERMION
```

## Widgets: DFermion

```@docs
create_app_dfermion
_dfermion_top_block
_dfermion_main_block
_dfermion_kmesh_block
```

## Structs: iQIST

```@docs
_CTSEG
_CTHYB
_ATOMIC
PCTHYB
PATOMIC
```

## Widgets: iQIST

```@docs
create_app_ctseg
_ctseg_top_block
_ctseg_main_block
_ctseg_model_block
_ctseg_represent_block
_ctseg_measure_block
_ctseg_cycle_block
_atomic_top_block
_atomic_model_block
```

## Structs: ACFlow

```@docs
PStochAC
ACFLOW_PBarRat
ACFLOW_PNevanAC
ACFLOW_PStochSK
ACFLOW_PStochPX
```

## Widgets: ACFlow

```@docs
_acflow_general_block
_acflow_stochac_block
_acflow_stochom_block
_acflow_stochpx_block
```

## Structs: ACTest

```@docs
```

## Widgets: ACTest

```@docs
_actest_main_block
_actest_bottom_block
_actest_general_block
_actest_solver_block
```

## Widgets: About

```@docs
create_app_about
```

## Functions: Setup

```@docs
setup_window
setup_background
```

## Functions: Save

```@docs
save_dfermion
save_ctseg
```
