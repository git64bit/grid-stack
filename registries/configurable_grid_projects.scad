//////////////////////////////////////////////////////////////////////
// LibFile: configurable_grid_projects.scad
// Project: Grid Stack
// FileGroup: Configurable Grid Records
// FileSummary: Builds the mutable process, count boundary, and path policy
//              used by the Coupon and Laboratory Customizer workbenches.
// Role: Makes presets the source of experimental object parameters while the
//       shared geometry engine remains fixed.
//////////////////////////////////////////////////////////////////////

CONFIGURABLE_GRID_PROCESS_PROFILES = [
    process_profile(
        name = "WORKBENCH_GRID_PROCESS",
        material_name = "PLA_PLUS",
        nozzle_name = "BRASS_0P4",
        layer_height = wb_grid_deposited_layer_height,
        width_passes = 2,
        height_passes = 2,
        bridge_max = 6.0,
        qualification = "laboratory_unqualified",
        revision = 1,
        notes = "Mutable Customizer process. Promote accepted settings into an immutable catalog recipe."
    )
];

CONFIGURABLE_GRID_BOUNDARIES = [
    count_boundary(
        name = "WORKBENCH_COUNT_BOUNDARY",
        cells_x = wb_grid_cells_x,
        cells_y = wb_grid_cells_y,
        clear_span_x = wb_grid_clear_span_x,
        clear_span_y = wb_grid_clear_span_y,
        kind = "rectangle",
        sides = 4,
        rotation = 0,
        edge_margin = 0,
        notes = "Mutable rectangular count boundary supplied by a workbench preset."
    )
];

CONFIGURABLE_GRID_PATH_POLICIES = [
    path_policy(
        name = "WORKBENCH_GRID_PATH",
        lead_in = wb_grid_lead_in,
        lead_out = 0,
        require_continuous = true,
        allow_travel = false,
        allow_lift = false,
        allow_closed_subpaths = false,
        start_rule = "lead_in_starts_outside_boundary",
        end_rule = "single_open_end",
        notes = "One continuous open path per deposited layer."
    )
];
