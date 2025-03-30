#
# Project : Camellia
# Source  : ZenGui.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/03/29
#

"""
    ZenGui

"""
module ZenGui

using CImGui
using CImGui.lib
using CImGui.CSyntax
using CImGui.CSyntax.CStatic

import GLFW
import ModernGL as GL

include("global.jl")

include("util.jl")

include("menu.jl")

include("zen.jl")
include("dyson.jl")
include("dfermion.jl")

include("ctseg.jl")
include("cthyb.jl")
include("atomic.jl")

include("acflow.jl")
include("actest.jl")

include("about.jl")

include("base.jl")
export zeng_run

end
