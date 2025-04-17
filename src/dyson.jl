#
# Project : Camellia
# Source  : dyson.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2025/04/17
#

"""
    create_app_dyson(p_open::Ref{Bool})

Create an UI window for the Dyson code, which is a dynamical mean-field
theory engine.
"""
function create_app_dyson(p_open::Ref{Bool})
    # Create the Dyson window, which can not be resized.
    CImGui.Begin(
        "Dyson",
        p_open,
        CImGui.ImGuiWindowFlags_NoResize
    )

    # Setup the flag for active window
    if CImGui.IsWindowFocused()
        CWIN.name = "DYSON"
    end

    # Fix size of the window
    window_width = 600.0
    window_height = 600.0
    CImGui.SetWindowSize(ImVec2(window_width, window_height))

    # For all the blocks in the dmft.in
    _dyson_main_block()

    # For the separator
    CImGui.Spacing()
    CImGui.Separator()
    CImGui.Spacing()

    # For the buttons in the bottom of this window
    _dyson_bottom_block(p_open)

    # End of this window
    CImGui.End()
end

"""
    _dyson_main_block()

Setup widgets for the parameters in the dmft.in.
"""
function _dyson_main_block()
    # Define the default size for widgets
    widget_input_width = 100
    widget_combo_width = 100

    # Input: task
    CImGui.SetNextItemWidth(widget_combo_width)
    task_list = ["dmft1", "dmft2", "fermi level", "impurity level", "eigenvalues", "spectral", "density of states", "to be done"]
    @cstatic id = Cint(0) begin
        @c CImGui.Combo(" Running mode of the code", &id, task_list)
        PDYSON.task = id + 1
    end
    CImGui.SameLine()
    CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "(task)$(PDYSON.task)")
end

"""
    _dyson_bottom_block(p_open::Ref{Bool})

Setup widgets in the bottom of the window for the Dyson code.
"""
function _dyson_bottom_block(p_open::Ref{Bool})
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
            text = _dict_to_toml(_build_dyson_dict())
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
