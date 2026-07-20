//////////////////////////////////////////////////////////////////////
// LibFile: schema.scad
// Project: Grid Stack
// FileGroup: API v2 Data Model
// FileSummary: Constructors for immutable first-layer printing records.
// Role: Separates a primitive nozzle trace from the API v1 structural-strand
//       process, which contains bridge and multi-pass fields irrelevant to a
//       one-layer calibration or anti-warp underlay.
// Exports: material_spec(), nozzle_spec(), printer_spec(),
//          trace_process_profile(), and first_layer_object().
//////////////////////////////////////////////////////////////////////

// Function: material_spec()
// Synopsis: Constructs one exact material-family identity.
function material_spec(name, family, flexibility, status, notes = "") =
    [name, family, flexibility, status, notes];

// Function: nozzle_spec()
// Synopsis: Constructs one exact nozzle-hardware identity.
function nozzle_spec(name, diameter, construction, status, notes = "") =
    [name, diameter, construction, status, notes];

// Function: printer_spec()
// Synopsis: Constructs one printer-hardware identity.
// Description:
//   Use a stable local name even when full hardware details are unavailable.
//   An explicitly unrecorded printer is preferable to inventing a model.
function printer_spec(
    name,
    manufacturer,
    model,
    motion_system,
    build_surface,
    status,
    notes = ""
) = [
    name,
    manufacturer,
    model,
    motion_system,
    build_surface,
    status,
    notes
];

// Function: trace_process_profile()
// Synopsis: Constructs a qualified primitive-trace printing environment.
// Description:
//   This record intentionally excludes structural width passes, structural
//   height passes, and bridge limits. One primitive trace is defined only by
//   material, nozzle, printer, and deposited layer height.
function trace_process_profile(
    name,
    material_name,
    nozzle_name,
    printer_name,
    layer_height,
    qualification,
    revision,
    notes = ""
) = [
    name,
    material_name,
    nozzle_name,
    printer_name,
    layer_height,
    qualification,
    revision,
    notes
];

// Function: first_layer_object()
// Synopsis: Constructs one immutable first-layer geometry recipe.
// Description:
//   traces contains [axis_min, axis_max, perpendicular_position] records.
//   source_commit identifies the accepted source state from which this recipe
//   was promoted. A changed printed object receives a new file and revision.
function first_layer_object(
    name,
    revision,
    required_api_version,
    first_layer_schema_version,
    source_release,
    source_commit,
    material,
    nozzle,
    printer,
    process,
    traces,
    orientation,
    lead_in,
    status,
    notes = ""
) = [
    name,
    revision,
    required_api_version,
    first_layer_schema_version,
    source_release,
    source_commit,
    material,
    nozzle,
    printer,
    process,
    traces,
    orientation,
    lead_in,
    status,
    notes
];
