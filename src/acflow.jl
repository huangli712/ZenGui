#
# Project : Camellia
# Source  : acflow.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/06
#

"""
    create_app_acflow(p_open::Ref{Bool})

Create an UI window for the ACFlow toolkit.
"""
function create_app_acflow(p_open::Ref{Bool})
    # Create the ACFlow window, which can not be resized.
    CImGui.Begin(
        "ACFlow",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    # Below the widgets are placed one by one.

    # Input: finput
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.InputText(" Filename for input data", PBASE.finput, length(PBASE.finput))
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(finput)")
    #
    # Input: solver
    CImGui.SetNextItemWidth(widget_combo_width)
    solver_list = ["MaxEnt", "BarRat", "NevanAC", "StochAC", "StochSK", "StochOM", "StochPX"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Solver for the analytic continuation problem", &id, solver_list)
        PBASE.solver = solver_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(solver)")
    #
    # Input: ktype
    CImGui.SetNextItemWidth(widget_combo_width)
    ktype_list = ["fermi", "boson", "bsymm"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Type of kernel function", &id, ktype_list)
        PBASE.ktype = ktype_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ktype)")
    #
    # Input: mtype
    CImGui.SetNextItemWidth(widget_combo_width)
    mtype_list = ["flat", "gauss", "1gauss", "2gauss", "lorentz", "1lorentz", "2lorentz", "risedecay", "file"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Type of default model function", &id, mtype_list)
        PBASE.mtype = mtype_list[id + 1]
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mtype)$(PBASE.mtype)")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "grid   :")
    CImGui.SameLine()
    CImGui.Text("Grid for input data (imaginary axis)")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "mesh   :")
    CImGui.SameLine()
    CImGui.Text("Mesh for output data (real axis)")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "ngrid  :")
    CImGui.SameLine()
    CImGui.Text("Number of grid points")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "nmesh  :")
    CImGui.SameLine()
    CImGui.Text("Number of mesh points")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "wmax   :")
    CImGui.SameLine()
    CImGui.Text("Right boundary (maximum value) of output mesh")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "wmin   :")
    CImGui.SameLine()
    CImGui.Text("Left boundary (minimum value) of output mesh")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "beta   :")
    CImGui.SameLine()
    CImGui.Text("Inverse temperature")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "offdiag:")
    CImGui.SameLine()
    CImGui.Text("Is it the offdiagonal part in matrix-valued function")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "fwrite :")
    CImGui.SameLine()
    CImGui.Text("Are the analytic continuation results written into files")
    CImGui.SameLine()
    CImGui.SetNextItemWidth(widget_input_width)
    CImGui.Text("TODO")
    #
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Dummy(ImVec2(0.0,10.0))

    button_width = 80.0
    button_height = 25.0
    if CImGui.Button("Generate", ImVec2(button_width, button_height))
        @show PBASE
    end

    # End of this window
    CImGui.End()
end
