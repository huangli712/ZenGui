#
# Project : Camellia
# Source  : ZenGui.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/22
#

"""
    ZenGui

ZenGui is a general-purpose graphic user interface for ab initio dynamical
mean-field theory codes, which have been developed at the China Academy of
Engineeing Physics. It should be used to generate necessary configuration
files for them. Now it supports the following codes:

* All-in-one DFT + DMFT package (**Zen**)
* Quantum impurity solver toolkit (**iQIST**)
* Analytic continuation tools (**ACFlow** and **ACTest**)
* Dynamical mean-field theory engines (**Dyson** and **DFermion**)

More codes will be supported in the future. Now this code is under heavy
development. **PLEASE USE IT AT YOUR OWN RISK**.

For more details about how to obtain, install and use this ZenGui app,
please visit the following website:

* `https://huangli712.github.io/projects/zengui/index.html`

Any suggestions, comments, and feedbacks are welcome. Enjoy it!
"""
module ZenGui

#=
### *Using Standard Libraries*
=#

using Dates
using Printf
using TOML
using Base.Sys

#=
### *Using Third-Party Libraries*
=#

#=
The OrderedCollections library provides support to the OrderedDict struct.
=#

using OrderedCollections

#=
The ZenGui application relies on the **Dear ImGui library**, which is a
C++ immediate mode graphic user interface library. Note that **CImGui**
is a C-API wrapper for **Dear ImGui**, and **CImGui.jl** provides a Julia
interface to **CImGui**. **GLFW** is an open source multi-platform library
for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides
a simple API for creating windows, contexts and surfaces, receiving input
and events. **ModernGL** is a OpenGL binding for Julia. Here, **GLFW**
and **ModernGL** are backends for **Dear ImGui**.
=#

using CImGui
using CImGui.lib
using CImGui.CSyntax
using CImGui.CSyntax.CStatic

using GLFW
using ModernGL

#=
### *Includes And Exports* : *global.jl*
=#

#=
*Summary* :

Define some type aliases and string constants for the ZenGui app.

*Members* :

```text
I32, I64, API -> Numerical types (Integer).
F32, F64, APF -> Numerical types (Float).
C32, C64, APC -> Numerical types (Complex).
R32, R64, APR -> Numerical types (Union of Integer and Float).
N32, N64, APN -> Numerical types (Union of Integer, Float, and Complex).
#
__LIBNAME__   -> Name of this julia toolkit.
__VERSION__   -> Version of this julia toolkit.
__RELEASE__   -> Released date of this julia toolkit.
__AUTHORS__   -> Authors of this julia toolkit.
#
authors       -> Print the authors of ZenGui to screen.
```
=#

#
include("global.jl")
#
export I32, I64, API
export F32, F64, APF
export C32, C64, APC
export R32, R64, APR
export N32, N64, APN
#
export __LIBNAME__
export __VERSION__
export __RELEASE__
export __AUTHORS__
#
export authors

#=
### *Includes And Exports* : *util.jl*
=#

#=
*Summary* :

To provide some useful utility macros and functions.

*Members* :

```text
@cswitch -> C-style switch.
#
sorry    -> Say sorry.
#
_dict_to_toml -> Convert dictionary to toml.
_dict_to_string -> Convert dictionary to string.
```
=#

#
include("util.jl")
#
export @cswitch
#
export sorry
#
export _dict_to_toml
export _dict_to_string

#=
### *Includes And Exports* : *types.jl*
=#

#=
*Summary* :

Define some dicts and structs, which are used to store the config
parameters or represent some essential data structures.

*Members* :

```text
CURRENT_WINDOW
CWIN
#
MenuFlags
FMENU
#
ZEN_PCASE
ZEN_PDFT
ZEN_PDMFT
ZEN_PIMPURITY
ZEN_PSOLVER
PCASE
PDFT
PDMFT
PIMPURITY
PSOLVER
#
DYSON_PDYSON
_DYSON
PDYSON
#
DFERMION_PDFERMION
_DFERMION
PDFERMION
#
IQIST_PCTSEG
IQIST_PCTHYB
IQIST_PATOMIC
_CTSEG
_CTHYB
_ATOMIC
PCTSEG
PCTHYB
PATOMIC
#
ACFLOW_PBASE
ACFLOW_PMaxEnt
ACFLOW_PBarRat
ACFLOW_PNevanAC
ACFLOW_PStochAC
ACFLOW_PStochSK
ACFLOW_PStochOM
ACFLOW_PStochPX
PBASE
PMaxEnt
PBarRat
PNevanAC
PStochAC
PStochSK
PStochOM
PStochPX
#
ACTEST_PTEST
PTEST
#
_struct_to_dict
#
_build_zen_dict
_build_dyson_dict
_build_dfermion_dict
_build_iqist_dict
_build_acflow_dict
_build_actest_dict
```
=#

#
include("types.jl")
#
export CURRENT_WINDOW
export CWIN
#
export MenuFlags
export FMENU
#
export ZEN_PCASE
export ZEN_PDFT
export ZEN_PDMFT
export ZEN_PIMPURITY
export ZEN_PSOLVER
export PCASE
export PDFT
export PDMFT
export PIMPURITY
export PSOLVER
#
export DYSON_PDYSON
export _DYSON
export PDYSON
#
export DFERMION_PDFERMION
export _DFERMION
export PDFERMION
#
export IQIST_PCTSEG
export IQIST_PCTHYB
export IQIST_PATOMIC
export _CTSEG
export _CTHYB
export _ATOMIC
export PCTSEG
export PCTHYB
export PATOMIC
#
export ACFLOW_PBASE
export ACFLOW_PMaxEnt
export ACFLOW_PBarRat
export ACFLOW_PNevanAC
export ACFLOW_PStochAC
export ACFLOW_PStochSK
export ACFLOW_PStochOM
export ACFLOW_PStochPX
export PBASE
export PMaxEnt
export PBarRat
export PNevanAC
export PStochAC
export PStochSK
export PStochOM
export PStochPX
#
export ACTEST_PTEST
export PTEST
#
export _struct_to_dict
#
export _build_zen_dict
export _build_dyson_dict
export _build_dfermion_dict
export _build_iqist_dict
export _build_acflow_dict
export _build_actest_dict

#=
### *Includes And Exports* : *save.jl*
=#

#=
*Summary* :

Save configuration files for various codes.

*Members* :

```text
save_zen      -> Write case.toml for the Zen package.
save_dyson    -> Write dmft.in for the Dyson code.
save_dfermion -> Write dfa.in for the DFermion code.
save_ctseg    -> Write solver.ctqmc.in for the iQIST/ctseg code.
save_cthyb    -> Write solver.ctqmc.in for the iQIST/cthyb code.
save_atomic   -> Write solver.ctqmc.in for the iQIST/atomic code.
save_acflow   -> Write ac.toml for the ACFlow toolkit.
save_actest   -> Write act.toml for the ACTest toolkit.
save_nothing  -> Write nothing.
```
=#

#
include("save.jl")
#
export save_zen
export save_dyson
export save_dfermion
export save_ctseg
export save_cthyb
export save_atomic
export save_acflow
export save_actest
export save_nothing

#=
### *Includes And Exports* : *menu.jl*
=#

#=
*Summary* :

Setup global menu for the ZenGui app.

*Members* :

```text
create_menu    -> Create all the menu.
#
set_menu_file  -> Create the menu items in ``File''.
set_menu_edit  -> Create the menu items in ``Edit''.
set_menu_style -> Create the menu items in ``Style''.
set_menu_help  -> Create the menu items in ``Help''.
```
=#

#
include("menu.jl")
#
export create_menu
#
export set_menu_file
export set_menu_edit
export set_menu_style
export set_menu_help

#
include("zen.jl")
#
export create_app_zen

#
include("dyson.jl")
#
export create_app_dyson

#
include("dfermion.jl")
#
export create_app_dfermion

#
include("ctseg.jl")
#
export create_app_ctseg

#=
### *Includes And Exports* : *cthyb.jl*
=#

#=
*Summary* :

Create and display the `cthyb` window for the iQIST/cthyb code.

*Members* :

```text
create_app_cthyb -> Create and display the `cthyb` window.
```
=#

#
include("cthyb.jl")
#
export create_app_cthyb

#
include("atomic.jl")
#
export create_app_atomic

#
include("acflow.jl")
#
export create_app_acflow
#
export _acflow_base_block
export _acflow_solver_block
export _acflow_bottom_block
#
export _acflow_maxent_block
export _acflow_barrat_block
export _acflow_nevanac_block
export _acflow_stochac_block
export _acflow_stochsk_block
export _acflow_stochom_block
export _acflow_stochpx_block

#
include("actest.jl")
#
export create_app_actest

#=
### *Includes And Exports* : *about.jl*
=#

#=
*Summary* :

Create and display the `About` window for the ZenGui app.

*Members* :

```text
create_app_about -> Create and display the `About` window.
```
=#

#
include("about.jl")
#
export create_app_about

#
include("base.jl")
#
export zeng_run
#
export setup_flags
export setup_fonts
export setup_window
#
export handle_menu_save
export handle_menu_classic
export handle_menu_dark
export handle_menu_light
export handle_menu_zen
export handle_menu_dyson
export handle_menu_dfermion
export handle_menu_iqist
export handle_menu_acflow
export handle_menu_actest
export handle_menu_zengui

end
