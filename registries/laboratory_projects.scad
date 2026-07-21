//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_projects.scad
// Project: Grid Stack
// FileGroup: Laboratory Registry
// FileSummary: Configurable printable laboratory projects plus explicit
//              deferred-project stubs.
// Role: Lets experimental Grid Stack objects use the frozen engine before
//       physical acceptance and later promotion into Catalog.
// Requires: Resolved wb_lab_* values and record constructors.
// Exports: LABORATORY_PROCESS_PROFILES, LABORATORY_BOUNDARIES,
//          LABORATORY_PATH_POLICIES, LABORATORY_PRINTABLE_PROJECTS,
//          LABORATORY_DEFERRED_PROJECTS, and LABORATORY_PROJECTS.
//////////////////////////////////////////////////////////////////////


LABORATORY_PROCESS_PROFILES = [
    process_profile(
        name = "LAB_PLA_PLUS_0P4_CURRENT",
        material_name = "PLA_PLUS",
        nozzle_name = "BRASS_0P4",
        layer_height = wb_lab_deposited_layer_height,
        width_passes = 2,
        height_passes = 2,
        bridge_max = 6.0,
        qualification = "laboratory_unqualified",
        revision = 1,
        notes = str(
            "Mutable laboratory process. Uniform deposited layer height is ",
            wb_lab_deposited_layer_height,
            " mm. Promotion requires a new immutable qualified profile."
        )
    )
];

LABORATORY_BOUNDARIES = [
    count_boundary(
        name = "LAB_GRID_PANEL_BOUNDARY",
        cells_x = wb_lab_cells_x,
        cells_y = wb_lab_cells_y,
        clear_span_x = wb_lab_clear_span_x,
        clear_span_y = wb_lab_clear_span_y,
        kind = "rectangle",
        sides = 4,
        rotation = 0,
        edge_margin = 0,
        notes = "Mutable laboratory count boundary; defaults to a 9 x 9 grid."
    )
];

LABORATORY_PATH_POLICIES = [
    path_policy(
        name = "LAB_GRID_PANEL_PATH",
        lead_in = wb_lab_lead_in,
        lead_out = 0,
        require_continuous = true,
        allow_travel = false,
        allow_lift = false,
        allow_closed_subpaths = false,
        start_rule = "lead_in_starts_outside_boundary",
        end_rule = "single_open_end",
        notes = "Mutable laboratory lead-in with the frozen one-path policy."
    )
];

LABORATORY_PRINTABLE_PROJECTS = [
    project_spec(
        name = "GRID_PANEL_LAB",
        process_name = "LAB_PLA_PLUS_0P4_CURRENT",
        boundary_name = "LAB_GRID_PANEL_BOUNDARY",
        path_policy_name = "LAB_GRID_PANEL_PATH",
        pattern_set_name = "SQUARE_COUPON",
        schedule_name = coupon_schedule_name(0),
        notes = "Printable laboratory grid panel; defaults to 9 x 9 cells at 6 mm clear span."
    )
];

LABORATORY_DEFERRED_PROJECTS = [
    project_spec(
        name = "TUTORIAL_RECT_45654",
        process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        boundary_name = "RECT_200X100",
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "OUTER2_SQUARE_INNER_HEX",
        schedule_name = "XGRID4_YGRID5_XGRID6_YGRID5_XGRID4",
        notes = "STUB: dimension boundary, mixed pattern, and expanded stack."
    )
];

// Compatibility alias retained for Batch 012 references.
DEFERRED_PROJECTS = LABORATORY_DEFERRED_PROJECTS;

LABORATORY_PROJECTS = concat(
    LABORATORY_PRINTABLE_PROJECTS,
    LABORATORY_DEFERRED_PROJECTS
);
