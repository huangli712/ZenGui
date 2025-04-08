#
# Project : Camellia
# Source  : ZenGui.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/08
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

#=
### *Using Third-Party Libraries*
=#

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

import GLFW
import ModernGL as GL

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

#
include("util.jl")
#
export @cswitch
export sorry
#
export setup_flags
export setup_fonts


include("types.jl")

include("menu.jl")
export create_menu
export set_menu_file
export set_menu_edit
export set_menu_style
export set_menu_help

include("zen.jl")

include("dyson.jl")
include("dfermion.jl")

include("ctseg.jl")
include("cthyb.jl")
include("atomic.jl")

include("acflow.jl")
include("actest.jl")

include("about.jl")
export create_app_about

include("base.jl")
export zeng_run

end
