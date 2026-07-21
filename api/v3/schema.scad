//////////////////////////////////////////////////////////////////////
// LibFile: schema.scad
// Project: Grid Stack
// FileGroup: API v3 Data Model
// FileSummary: Constructors for self-contained immutable structural coupons.
// Role: Makes every geometry-affecting environment and object value explicit
//       inside the saved recipe rather than resolving mutable catalog names.
// Exports: material_spec(), nozzle_spec(), printer_spec(),
//          structural_process_profile(), count_boundary(), and
//          structural_coupon_object().
//////////////////////////////////////////////////////////////////////

function material_spec(
    name, family, flexibility, status = "in_use", notes = ""
) = [name, family, flexibility, status, notes];

function nozzle_spec(
    name, diameter, construction = "brass", status = "in_use", notes = ""
) = [name, diameter, construction, status, notes];

function printer_spec(
    name,
    manufacturer = "",
    model = "",
    motion_system = "",
    build_surface = "",
    status = "unrecorded",
    notes = ""
) = [
    name, manufacturer, model, motion_system,
    build_surface, status, notes
];

function structural_process_profile(
    name,
    material_name,
    nozzle_name,
    printer_name,
    layer_height,
    width_passes,
    height_passes,
    bridge_max,
    qualification,
    revision,
    notes = ""
) = [
    name, material_name, nozzle_name, printer_name,
    layer_height, width_passes, height_passes, bridge_max,
    qualification, revision, notes
];

// Function: count_boundary()
// Synopsis: Stores clear-opening counts and clear spans for one rectangle.
function count_boundary(
    name,
    cells_x,
    cells_y,
    clear_span_x,
    clear_span_y,
    notes = ""
) = [name, cells_x, cells_y, clear_span_x, clear_span_y, notes];

// Function: structural_coupon_object()
// Synopsis: Constructs one permanent coupon recipe.
// Description:
//   framework_base_commit records the last accepted repository state used to
//   begin the API implementation. The Git commit containing this recipe is the
//   authoritative complete source; a file cannot embed its own future hash.
function structural_coupon_object(
    name,
    revision,
    required_api_version,
    coupon_schema_version,
    source_release,
    framework_base_commit,
    material,
    nozzle,
    printer,
    process,
    boundary,
    clear_vertical_gap,
    lead_in,
    support_strategy,
    status = "calibration",
    notes = ""
) = [
    name,
    revision,
    required_api_version,
    coupon_schema_version,
    source_release,
    framework_base_commit,
    material,
    nozzle,
    printer,
    process,
    boundary,
    clear_vertical_gap,
    lead_in,
    support_strategy,
    status,
    notes
];
