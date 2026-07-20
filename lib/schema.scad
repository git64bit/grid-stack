//////////////////////////////////////////////////////////////////////
// LibFile: schema.scad
// Project: Grid Stack
// FileGroup: Data Model
// FileSummary: Constructor functions for every record-like vector.
// Role: Centralizes field order while configuration files use named arguments.
// Exports: Environment, boundary, path, pattern, stack, project, coupon,
//          Grid Stack object, and first-layer object constructors.
//////////////////////////////////////////////////////////////////////

// Section: Project Environment Records

// Function: material_spec()
// Synopsis: Constructs a material-family record without hardware dimensions.
// Arguments:
//   name = Stable record name used by lookup.
//   family = Human-readable filament family.
//   flexibility = Broad behavior class such as rigid or flexible.
//   status = Catalog status, such as in_use or reserved.
//   notes = Qualification and sourcing notes.
function material_spec(name, family, flexibility, status, notes = "") =
    [name, family, flexibility, status, notes];

// Function: nozzle_spec()
// Synopsis: Constructs a nozzle-hardware record.
// Arguments:
//   name = Stable record name used by lookup.
//   diameter = Nominal nozzle diameter in millimeters.
//   construction = Nozzle material or construction class.
//   status = Catalog status, such as in_use or reserved.
//   notes = Hardware notes.
function nozzle_spec(name, diameter, construction, status, notes = "") =
    [name, diameter, construction, status, notes];

// Function: process_profile()
// Synopsis: Constructs one qualified material/nozzle printing environment.
// Description:
//   A process profile is immutable by convention. When material, nozzle,
//   layer height, pass count, or tested behavior changes, add a new profile
//   with a new name and revision instead of silently changing the old one.
function process_profile(
    name,
    material_name,
    nozzle_name,
    layer_height,
    width_passes,
    height_passes,
    bridge_max,
    qualification,
    revision,
    notes = ""
) = [
    name,
    material_name,
    nozzle_name,
    layer_height,
    width_passes,
    height_passes,
    bridge_max,
    qualification,
    revision,
    notes
];

// Section: Boundary Records

// Function: dimension_boundary()
// Synopsis: Constructs a perimeter-driven boundary with explicit dimensions.
// Description:
//   Use this constructor when the finished outside dimensions matter and the
//   path generator will later determine how many cells fit inside them.
function dimension_boundary(
    name,
    kind,
    size_x,
    size_y,
    sides = 0,
    rotation = 0,
    edge_margin = 0,
    notes = ""
) = [
    name, "dimension", kind, size_x, size_y,
    0, 0, 0, 0,
    sides, rotation, edge_margin, notes
];

// Function: count_boundary()
// Synopsis: Constructs a grid-driven rectangular boundary.
// Description:
//   cells_x and cells_y count clear openings, not structural strands.
//   A count of three openings requires four structural strands.
//   Outside dimensions are derived from cell count, clear span, strand width,
//   and optional edge margin.
function count_boundary(
    name,
    cells_x,
    cells_y,
    clear_span_x,
    clear_span_y,
    kind = "rectangle",
    sides = 4,
    rotation = 0,
    edge_margin = 0,
    notes = ""
) = [
    name, "count", kind, 0, 0,
    cells_x, cells_y, clear_span_x, clear_span_y,
    sides, rotation, edge_margin, notes
];

// Section: Path and Pattern Records

function path_policy(
    name, lead_in, lead_out, require_continuous = true,
    allow_travel = false, allow_lift = false,
    allow_closed_subpaths = false, start_rule = "outside_boundary",
    end_rule = "inside_or_outside", notes = ""
) = [
    name, lead_in, lead_out, require_continuous, allow_travel, allow_lift,
    allow_closed_subpaths, start_rule, end_rule, notes
];

// Function: pattern_zone()
// Synopsis: Constructs one topological pattern zone and spacing policy.
// Arguments:
//   spacing_source = fixed_pitch or boundary_clear_span.
//   strand_pitch = Used only when spacing_source is fixed_pitch.
function pattern_zone(
    name, pattern, band_kind, band_value, spacing_source,
    strand_pitch, connector, notes = ""
) = [
    name, pattern, band_kind, band_value, spacing_source,
    strand_pitch, connector, notes
];

function pattern_set(name, zones, transition, notes = "") =
    [name, zones, transition, notes];

// Section: Stack Schedule Records

// Function: strand_group()
// Synopsis: Constructs a consecutive group of completed structural strands.
// Description:
//   strand_count counts completed structural strands, not raw deposited layers.
//   clear_gap_after is empty vertical distance after the complete group.
function strand_group(
    orientation,
    strand_count,
    pattern_set_name,
    clear_gap_after = 0,
    notes = ""
) = [
    orientation, strand_count, pattern_set_name, clear_gap_after, notes
];

function stack_schedule(name, groups, require_symmetry = false, notes = "") =
    [name, groups, require_symmetry, notes];

// Section: Project and Test Records

function project_spec(
    name,
    process_name,
    boundary_name,
    path_policy_name,
    pattern_set_name,
    schedule_name,
    notes = ""
) = [
    name,
    process_name,
    boundary_name,
    path_policy_name,
    pattern_set_name,
    schedule_name,
    notes
];

// Function: coupon_series()
// Synopsis: Constructs a Cartesian test matrix from named boundaries and
//           named stack schedules.
// Description:
//   Boundary records vary horizontal clear span. Stack schedules vary vertical
//   clear gap. Every boundary/schedule pair is one coupon case.
function coupon_series(
    name,
    process_name,
    boundary_names,
    schedule_names,
    path_policy_name,
    pattern_set_name,
    notes = ""
) = [
    name,
    process_name,
    boundary_names,
    schedule_names,
    path_policy_name,
    pattern_set_name,
    notes
];

// Section: Saved Object Records

// Function: grid_stack_object()
// Synopsis: Constructs one self-contained permanent Grid Stack recipe record.
// Description:
//   Embedded records are copied into the recipe instead of resolved from
//   mutable configuration catalogs. The required API and object-schema values
//   prevent silent execution against an incompatible public interface.
function grid_stack_object(
    name,
    revision,
    required_api_version,
    object_schema_version,
    source_release,
    material,
    nozzle,
    process,
    boundary,
    path_policy_record,
    pattern_set_record,
    schedule,
    path_orientation = 0,
    status = "draft",
    notes = ""
) = [
    name,
    revision,
    required_api_version,
    object_schema_version,
    source_release,
    material,
    nozzle,
    process,
    boundary,
    path_policy_record,
    pattern_set_record,
    schedule,
    path_orientation,
    status,
    notes
];

// Function: first_layer_object()
// Synopsis: Constructs one self-contained single-layer trace recipe.
// Description:
//   traces contains records of [axis_min, axis_max, perpendicular_position].
//   Every length and repeat distance is explicit. Trace width derives from the
//   embedded nozzle and trace height derives from the embedded process layer.
function first_layer_object(
    name,
    revision,
    required_api_version,
    first_layer_schema_version,
    source_release,
    material,
    nozzle,
    process,
    traces,
    orientation = 0,
    lead_in = 0,
    status = "draft",
    notes = ""
) = [
    name,
    revision,
    required_api_version,
    first_layer_schema_version,
    source_release,
    material,
    nozzle,
    process,
    traces,
    orientation,
    lead_in,
    status,
    notes
];
