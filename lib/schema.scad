/* Constructors keep record order in one place. Use named arguments when
   declaring records so configuration remains readable. */

function material_profile(
    name,
    nozzle_d,
    line_width,
    layer_height,
    bridge_max,
    bridge_strand_width,
    bridge_build_layers,
    min_clear_gap,
    max_clear_gap,
    notes = ""
) = [
    name,
    nozzle_d,
    line_width,
    layer_height,
    bridge_max,
    bridge_strand_width,
    bridge_build_layers,
    min_clear_gap,
    max_clear_gap,
    notes
];

function boundary_profile(
    name,
    kind,
    size_x,
    size_y,
    sides = 0,
    rotation = 0,
    edge_margin = 0,
    notes = ""
) = [
    name,
    kind,
    size_x,
    size_y,
    sides,
    rotation,
    edge_margin,
    notes
];

function path_policy(
    name,
    lead_in,
    lead_out,
    require_continuous = true,
    allow_travel = false,
    allow_lift = false,
    allow_closed_subpaths = false,
    start_rule = "outside_boundary",
    end_rule = "inside_or_outside",
    notes = ""
) = [
    name,
    lead_in,
    lead_out,
    require_continuous,
    allow_travel,
    allow_lift,
    allow_closed_subpaths,
    start_rule,
    end_rule,
    notes
];

function pattern_zone(
    name,
    pattern,
    band_kind,
    band_value,
    strand_pitch,
    connector,
    notes = ""
) = [
    name,
    pattern,
    band_kind,
    band_value,
    strand_pitch,
    connector,
    notes
];

function pattern_set(
    name,
    zones,
    transition,
    notes = ""
) = [name, zones, transition, notes];

function layer_group(
    orientation,
    count,
    pattern_set_name,
    z_step_multiplier = 1,
    notes = ""
) = [
    orientation,
    count,
    pattern_set_name,
    z_step_multiplier,
    notes
];

function layer_schedule(
    name,
    groups,
    require_symmetry = false,
    notes = ""
) = [name, groups, require_symmetry, notes];

function project_spec(
    name,
    material_name,
    boundary_name,
    path_policy_name,
    pattern_set_name,
    schedule_name,
    notes = ""
) = [
    name,
    material_name,
    boundary_name,
    path_policy_name,
    pattern_set_name,
    schedule_name,
    notes
];
