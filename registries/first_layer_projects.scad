//////////////////////////////////////////////////////////////////////
// LibFile: first_layer_projects.scad
// Project: Grid Stack
// FileGroup: First-Layer Registry
// FileSummary: Registers the variable parallel-trace first-layer workbench.
// Role: Makes first-layer calibration and sacrificial underlays available to
//       the same named-preset workflow as other Grid Stack objects.
//////////////////////////////////////////////////////////////////////

FIRST_LAYER_PROJECTS = [
    project_spec(
        name = "FIRST_LAYER_TRACE_LAB",
        process_name = wb_first_layer_process_profile_name,
        boundary_name = "",
        path_policy_name = "",
        pattern_set_name = "",
        schedule_name = "",
        notes = "Single deposited layer built from independently configured parallel trace records."
    )
];
