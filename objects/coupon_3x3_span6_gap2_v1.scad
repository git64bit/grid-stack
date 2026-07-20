//////////////////////////////////////////////////////////////////////
// LibFile: coupon_3x3_span6_gap2_v1.scad
// Project: Grid Stack
// FileGroup: Saved Object Recipe
// FileSummary: Self-contained 3 x 3 calibration coupon recipe with 6 mm
//              horizontal clear spans and a 2 mm vertical clear gap.
// Role: Demonstrates the permanent saved-object contract without Customizer
//       values or mutable configuration-catalog lookup.
// Requires: Grid Stack API version 1.
// Output: API v1 diagnostic path preview; printable solids arrive later.
//////////////////////////////////////////////////////////////////////

include <../api/grid_stack_v1.scad>

assert(GRID_STACK_API_VERSION == 1,
    "This recipe requires Grid Stack API version 1.");

saved_material = material_spec(
    name = "PLA_PLUS",
    family = "PLA+",
    flexibility = "rigid",
    status = "in_use",
    notes = "Exact material family used by this saved object."
);

saved_nozzle = nozzle_spec(
    name = "BRASS_0P4",
    diameter = 0.4,
    construction = "brass",
    status = "in_use",
    notes = "Exact nozzle hardware used by this saved object."
);

saved_process = process_profile(
    name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    material_name = "PLA_PLUS",
    nozzle_name = "BRASS_0P4",
    layer_height = 0.2,
    width_passes = 2,
    height_passes = 2,
    bridge_max = 6.0,
    qualification = "owner_tested",
    revision = 1,
    notes = "Composed structural strand is 0.8 x 0.4 mm."
);

saved_boundary = count_boundary(
    name = "COUNT_3X3_SPAN6",
    cells_x = 3,
    cells_y = 3,
    clear_span_x = 6,
    clear_span_y = 6,
    edge_margin = 0,
    notes = "Three by three clear openings; outside size is derived."
);

saved_path_policy = path_policy(
    name = "ONE_PATH_WITH_LEAD_IN",
    lead_in = 30,
    lead_out = 0,
    require_continuous = true,
    allow_travel = false,
    allow_lift = false,
    allow_closed_subpaths = false,
    start_rule = "lead_in_starts_outside_boundary",
    end_rule = "single_open_end",
    notes = "Exactly one open nozzle path per deposited layer."
);

saved_pattern_set = pattern_set(
    name = "SQUARE_COUPON",
    zones = [
        pattern_zone(
            name = "coupon_square_grid",
            pattern = "square",
            band_kind = "entire_boundary",
            band_value = 0,
            spacing_source = "boundary_clear_span",
            strand_pitch = 0,
            connector = "square_turn",
            notes = "Pitch derives from clear span plus strand width."
        )
    ],
    transition = "none",
    notes = "Square calibration topology."
);

saved_schedule = stack_schedule(
    name = "X1_GAP2_Y1",
    groups = [
        strand_group(
            orientation = 0,
            strand_count = 1,
            pattern_set_name = "SQUARE_COUPON",
            clear_gap_after = 2,
            notes = "One completed lower X structural strand."
        ),
        strand_group(
            orientation = 90,
            strand_count = 1,
            pattern_set_name = "SQUARE_COUPON",
            clear_gap_after = 0,
            notes = "One completed upper Y structural strand."
        )
    ],
    require_symmetry = false,
    notes = "Calibration schedule with 2 mm clear vertical separation."
);

saved_object = grid_stack_object(
    name = "COUPON_3X3_SPAN6_GAP2_V1",
    revision = 1,
    required_api_version = 1,
    object_schema_version = 1,
    source_release = "0.5.0",
    material = saved_material,
    nozzle = saved_nozzle,
    process = saved_process,
    boundary = saved_boundary,
    path_policy_record = saved_path_policy,
    pattern_set_record = saved_pattern_set,
    schedule = saved_schedule,
    path_orientation = 0,
    status = "calibration",
    notes = "Permanent recipe; create V2 rather than editing after printing."
);

grid_stack_render(
    saved_object,
    mode = "path_preview",
    report_level = "full",
    show_boundary_envelope = true,
    show_path_point_numbers = true
);
