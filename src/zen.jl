#
# Project : Camellia
# Source  : zen.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/4/11
#

"""
    create_app_zen(p_open::Ref{Bool})

Create an UI window for the Zen toolkit, which is an integrated package for
ab initio dynamical mean-field theory calculations.
"""
function create_app_zen(p_open::Ref{Bool})
    # Create the Zen window, which can not be resized.
    CImGui.Begin(
        "Zen",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "ZEN"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the case.toml
    _zen_tabs_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _zen_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _zen_tabs_block()

Setup the tab widgets for all the blocks in the case.toml.
"""
function _zen_tabs_block()
    tab_bar_flags = CImGui.ImGuiTabBarFlags_None
    #
    if CImGui.BeginTabBar("ZenTabBar", tab_bar_flags)
        _zen_case_block()
        _zen_dft_block()
        _zen_dmft_block()
        _zen_imp_block()
        _zen_solver_block()
        #
        CImGui.EndTabBar()
    end
end

"""
    _zen_bottom_block(p_open::Ref{Bool})

Setup widgets in the bottom of the window for the Zen package.
"""
function _zen_bottom_block(p_open::Ref{Bool})
    # Define the default size for widgets
    widget_button_width = 80.0
    widget_button_height = 25.0

    # For the buttons
    if CImGui.Button("View", ImVec2(widget_button_width, widget_button_height))
        CImGui.OpenPopup("View")
    end
    #
    if CImGui.BeginPopupModal("View", C_NULL, CImGui.ImGuiWindowFlags_AlwaysAutoResize)
        @cstatic read_only=false text="Hello World!" begin
            text = _dict_to_toml(_build_zen_dict())
            @c CImGui.Checkbox("Read-only", &read_only)
            flags = read_only ? CImGui.ImGuiInputTextFlags_ReadOnly : 0
            flags = CImGui.ImGuiInputTextFlags_AllowTabInput | flags
            CImGui.InputTextMultiline("##source", text, 10000, ImVec2(400, 600), flags)
        end
        #
        if CImGui.Button("OK", ImVec2(widget_button_width, widget_button_height))
            CImGui.CloseCurrentPopup()
        end
        #
        CImGui.EndPopup()
    end
    #
    CImGui.SameLine()
    #
    if CImGui.Button("Close", ImVec2(widget_button_width, widget_button_height))
        p_open[] = false
    end
end

"""
    _zen_case_block()
"""
function _zen_case_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("case")
        CImGui.Text("Configure [case] block")

        # Input: case
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic buf = "SrVO3" * "\0"^60 begin
            CImGui.InputText(" System's name or seedname", buf, length(buf))
            PCASE.case = rstrip(buf,'\0')
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(case)$(PCASE.case)")

        CImGui.EndTabItem()
    end
end

"""
    _zen_dft_block()
"""
function _zen_dft_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("dft")
        CImGui.Text("Configure [dft] block")

        # Input: engine
        CImGui.SetNextItemWidth(widget_combo_width)
        engine_list = ["vasp", "qe"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Engine for density functional theory calculations", &id, engine_list)
            PDFT.engine = engine_list[id + 1]
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(engine)$(PDFT.engine)")
        #
        # Input: projtype
        CImGui.SetNextItemWidth(widget_combo_width)
        projtype_list = ["plo", "wannier"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Types of projectors", &id, projtype_list)
            PDFT.projtype = projtype_list[id + 1]
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(projtype)$(PDFT.projtype)")
        #
        # Input: smear
        CImGui.SetNextItemWidth(widget_combo_width)
        smear_list = ["mp2", "mp1", "gauss", "tetra"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Scheme for smearing", &id, smear_list)
            PDFT.smear = smear_list[id + 1]
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(smear)$(PDFT.smear)")
        #
        # Input: kmesh
        CImGui.SetNextItemWidth(widget_combo_width)
        kmesh_list = ["accurate", "medium", "coarse", "file"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" K-mesh for brillouin zone sampling / integration", &id, kmesh_list)
            PDFT.kmesh = kmesh_list[id + 1]
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(kmesh)$(PDFT.kmesh)")
        #
        # Input: magmom
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic buf = "0.0" * "\0"^60 begin
            CImGui.InputText(" Initial magnetic moments", buf, length(buf))
            PDFT.magmom = rstrip(buf,'\0')
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(magmom)$(PDFT.magmom)")
        #
        # Input: ncycle
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(8) begin
            @c CImGui.InputInt(" Number of DFT iterations per DFT + DMFT cycle", &_i)
            PDFT.ncycle = _i
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ncycle)$(PDFT.ncycle)")
        #
        # Input: lsymm
        CImGui.SetNextItemWidth(widget_combo_width)
        lsymm_list = ["Yes", "No"]
        @cstatic id = Cint(1) begin
            @c CImGui.Combo(" Is the symmetry turned on or off", &id, lsymm_list)
            if id == 0
                PDFT.lsymm = true
            else
                PDFT.lsymm = false
            end
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lsymm)$(PDFT.lsymm)")
        #
        # Input: lspins
        CImGui.SetNextItemWidth(widget_combo_width)
        lspins_list = ["Yes", "No"]
        @cstatic id = Cint(1) begin
            @c CImGui.Combo(" Are the spin orientations polarized or not", &id, lspins_list)
            if id == 0
                PDFT.lspins = true
            else
                PDFT.lspins = false
            end
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lspins)$(PDFT.lspins)")
        #
        # Input: lspinorb
        CImGui.SetNextItemWidth(widget_combo_width)
        lspinorb_list = ["Yes", "No"]
        @cstatic id = Cint(1) begin
            @c CImGui.Combo(" Is the spin-orbit coupling considered or not", &id, lspinorb_list)
            if id == 0
                PDFT.lspinorb = true
            else
                PDFT.lspinorb = false
            end
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lspinorb)$(PDFT.lspinorb)")
        #
        # Input: lproj
        CImGui.SetNextItemWidth(widget_combo_width)
        lproj_list = ["Yes", "No"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Are the projectors generated or not", &id, lproj_list)
            if id == 0
                PDFT.lproj = true
            else
                PDFT.lproj = false
            end
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lproj)$(PDFT.lproj)")

        # For the separator
        CImGui.Spacing()
        CImGui.Separator()
        CImGui.Spacing()

        # Input: nsite
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(1) begin
            @c CImGui.InputInt(" Number of (correlated) impurity sites", &_i)
            PIMP.nsite = _i
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(0.5,0.5,1.0,1.0), "(nsite)$(PIMP.nsite)")
        #
        # Input: sproj
        @assert 9 ≥ PIMP.nsite ≥ 1
        empty!(PDFT.sproj)
        for i = 1:PIMP.nsite
            CImGui.SetNextItemWidth(widget_input_width)
            #
            i == 1 && @cstatic buf1 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf1, length(buf1))
                push!(PDFT.sproj, rstrip(buf1,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 2 && @cstatic buf2 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf2, length(buf2))
                push!(PDFT.sproj, rstrip(buf2,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 3 && @cstatic buf3 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf3, length(buf3))
                push!(PDFT.sproj, rstrip(buf3,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 4 && @cstatic buf4 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf4, length(buf4))
                push!(PDFT.sproj, rstrip(buf4,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 5 && @cstatic buf5 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf5, length(buf5))
                push!(PDFT.sproj, rstrip(buf5,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 6 && @cstatic buf6 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf6, length(buf6))
                push!(PDFT.sproj, rstrip(buf6,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 7 && @cstatic buf7 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf7, length(buf7))
                push!(PDFT.sproj, rstrip(buf7,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 8 && @cstatic buf8 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf8, length(buf8))
                push!(PDFT.sproj, rstrip(buf8,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
            i == 9 && @cstatic buf9 = "1 : d : Pr" * "\0"^60 begin
                CImGui.InputText(" Specifications for generating projector $i", buf9, length(buf9))
                push!(PDFT.sproj, rstrip(buf9,'\0'))
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sproj_$i)")
            end
        end
        #
        # Input: window
        @assert 9 ≥ PIMP.nsite ≥ 1
        empty!(PDFT.window)
        for i = 1:PIMP.nsite
            CImGui.SetNextItemWidth(widget_input_width * 2)
            #
            i == 1 && @cstatic _f1 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f1,
                    2
                )
                push!(PDFT.window, _f1...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 2 && @cstatic _f2 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f2,
                    2
                )
                push!(PDFT.window, _f2...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 3 && @cstatic _f3 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f3,
                    2
                )
                push!(PDFT.window, _f3...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 4 && @cstatic _f4 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f4,
                    2
                )
                push!(PDFT.window, _f4...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 5 && @cstatic _f5 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f5,
                    2
                )
                push!(PDFT.window, _f5...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 6 && @cstatic _f6 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f6,
                    2
                )
                push!(PDFT.window, _f6...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 7 && @cstatic _f7 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f7,
                    2
                )
                push!(PDFT.window, _f7...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 8 && @cstatic _f8 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f8,
                    2
                )
                push!(PDFT.window, _f8...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
            i == 9 && @cstatic _f9 = Cdouble[0.0,1.0] begin
                CImGui.InputScalarN(
                    " Band window for normalizing projector $i",
                    CImGui.ImGuiDataType_Double,
                    _f9,
                    2
                )
                push!(PDFT.window, _f9...)
                CImGui.SameLine()
                CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(window_$i)")
            end
        end

        CImGui.EndTabItem()
    end
end

"""
    _zen_dmft_block()
"""
function _zen_dmft_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    if CImGui.BeginTabItem("dmft")
        CImGui.Text("Configure [dmft] block")

        # Input: mode
        CImGui.SetNextItemWidth(widget_combo_width)
        mode_list = ["1:one-shot", "2:self-consistent"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Scheme of dynamical mean-field theory calculations", &id, mode_list)
            PDMFT.mode = id + 1
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mode)$(PDMFT.mode)")
        #
        # Input: axis
        CImGui.SetNextItemWidth(widget_combo_width)
        axis_list = ["1:imaginary", "2:real"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Imaginary-time axis or real-frequency axis", &id, axis_list)
            PDMFT.axis = id + 1
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(axis)$(PDMFT.axis)")
        #
        # Input: niter
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(60) begin
            @c CImGui.SliderInt(" Maximum allowed number of DFT + DMFT iterations", &_i, 1, 100)
            PDMFT.niter = _i
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(niter)$(PDMFT.niter)")
        #
        # Input: nmesh
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _i = Cint(8193) begin
            @c CImGui.SliderInt(" Number of frequency points", &_i, 2^7+1, 2^14+1)
            PDMFT.nmesh = _i
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(nmesh)$(PDMFT.nmesh)")
        #
        # Input: dcount
        CImGui.SetNextItemWidth(widget_combo_width)
        dcount_list = ["fll1", "fll2", "amf", "held", "exact"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Scheme of double counting term", &id, dcount_list)
            PDMFT.dcount = dcount_list[id + 1]
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(dcount)$(PDMFT.dcount)")
        #
        # Input: beta
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(40.0) begin
            @c CImGui.InputDouble(" Inverse system temperature", &_f)
            PDMFT.beta = _f
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(beta)$(PDMFT.beta)")
        #
        # Input: mixer
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.1) vmin = Cdouble(0.0) vmax = Cdouble(1.0) begin
            @c CImGui.SliderScalar(
                " Mixing factor",
                CImGui.ImGuiDataType_Double,
                &_f,
                &vmin, &vmax
            )
            PDMFT.mixer = _f
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mixer)$(PDMFT.mixer)")
        #
        # Input: mc
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0001) begin
            @c CImGui.InputDouble(" Convergence criterion of chemical potential", &_f)
            PDMFT.mc = _f
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(mc)$(PDMFT.mc)")
        #
        # Input: cc
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(1.0e-6) begin
            @c CImGui.InputDouble(" Convergence criterion of charge", &_f)
            PDMFT.cc = _f
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(cc)$(PDMFT.cc)")
        #
        # Input: ec
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0001) begin
            @c CImGui.InputDouble(" Convergence criterion of total energy", &_f)
            PDMFT.ec = _f
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(ec)$(PDMFT.ec)")
        #
        # Input: sc
        CImGui.SetNextItemWidth(widget_input_width)
        @cstatic _f = Cdouble(0.0001) begin
            @c CImGui.InputDouble(" Convergence criterion of self-energy function", &_f)
            PDMFT.sc = _f
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(sc)$(PDMFT.sc)")
        #
        # Input: lfermi
        CImGui.SetNextItemWidth(widget_combo_width)
        lfermi_list = ["Yes", "No"]
        @cstatic id = Cint(0) begin
            @c CImGui.Combo(" Whether chemical potential should be updated", &id, lfermi_list)
            if id == 0
                PDMFT.lfermi = true
            else
                PDMFT.lfermi = false
            end
        end
        CImGui.SameLine()
        CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(lfermi)$(PDMFT.lfermi)")        

        CImGui.EndTabItem()
    end
end

macro _widgets_generator(x)
    ex = quote
        i = $x

        # Input: atoms
        @cstatic buf = "V : 2" * "\0"^60 begin
            CImGui.InputText(" Chemical symbols of impurity atom $i", buf, length(buf))
            push!(PIMP.atoms, rstrip(buf,'\0'))
            CImGui.SameLine()
            CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(atoms_$i)")
        end
        #
        #
    end

    return :( $(esc(ex)) )
end

"""
    _zen_imp_block()
"""
function _zen_imp_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    empty!(PIMP.atoms)
    if CImGui.BeginTabItem("impurity")
        CImGui.Text("Configure [impurity] block")

        for i = 1:PIMP.nsite

            i == 1 && @_widgets_generator 1
            i == 2 && @_widgets_generator 2

        end
        @show PIMP.atoms
        CImGui.EndTabItem()
    end
end

"""
    _zen_solver_block()
"""
function _zen_solver_block()
    if CImGui.BeginTabItem("solver")
        CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
        CImGui.EndTabItem()
    end
end
