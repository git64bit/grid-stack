//////////////////////////////////////////////////////////////////////
// LibFile: schema.scad
// Project: Grid Stack
// FileGroup: Data Model
// FileSummary: Constructor functions for every record-like vector.
// Role: Centralizes field order while configuration files use named arguments.
// Exports: material_spec(), nozzle_spec(), process_profile(), and all project
//          configuration constructors.
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
// Arguments:
//   name = Stable environment name.
//   material_name = Name from MATERIALS.
//   nozzle_name = Name from NOZZLES.
//   layer_height = Height of one deposited trace in millimeters.
//   width_passes = Adjacent traces composing one structural strand.
//   height_passes = Deposited layers composing one structural strand height.
//   bridge_max = Owner-tested maximum unsupported span in millimeters.
//   qualification = Status of the complete environment.
//   revision = Integer environment revision.
//   notes = Test and setup notes.
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

// Section: Geometry-Policy Records

function boundary_profile(
    name, kind, size_x, size_y, sides = 0, rotation = 0,
    edge_margin = 0, notes = ""
) = [name, kind, size_x, size_y, sides, rotation, edge_margin, notes];

function path_policy(
    name, lead_in, lead_out, require_continuous = true,
    allow_travel = false, allow_lift = false,
    allow_closed_subpaths = false, start_rule = "outside_boundary",
    end_rule = "inside_or_outside", notes = ""
) = [
    name, lead_in, lead_out, require_continuous, allow_travel, allow_lift,
    allow_closed_subpaths, start_rule, end_rule, notes
];

function pattern_zone(
    name, pattern, band_kind, band_value, strand_pitch,
    connector, notes = ""
) = [name, pattern, band_kind, band_value, strand_pitch, connector, notes];

function pattern_set(name, zones, transition, notes = "") =
    [name, zones, transition, notes];

function layer_group(
    orientation, count, pattern_set_name,
    z_step_multiplier = 1, notes = ""
) = [orientation, count, pattern_set_name, z_step_multiplier, notes];

function layer_schedule(name, groups, require_symmetry = false, notes = "") =
    [name, groups, require_symmetry, notes];

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
