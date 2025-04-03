#!/usr/bin/env julia

#
#
# Usage:
#
#     $ ./zeng.jl
#

haskey(ENV,"ZEN_GUI") && pushfirst!(LOAD_PATH, ENV["ZEN_GUI"])

using ZenGui

zeng_run()
