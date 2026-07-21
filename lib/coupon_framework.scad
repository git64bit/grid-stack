//////////////////////////////////////////////////////////////////////
// LibFile: coupon_framework.scad
// Project: Grid Stack
// FileGroup: Framework Contract
// FileSummary: Freezes the supported rectangular count-boundary coupon model
//              and names the extension points that remain deliberately stubbed.
// Role: Provides one validation and naming contract shared by the development
//       workbench, contract tests, and the future immutable coupon API.
// Requires: Field indexes, boundary/process/path/stack mathematics, and
//           nearly_equal() from list_math.scad.
// Exports: Framework version, coupon naming helpers, schedule helpers,
//          support predicates, validation, and stub assertions.
//////////////////////////////////////////////////////////////////////

GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION = 1;

// Function: coupon_project_name()
// Synopsis: Returns the canonical project name for one coupon specification.
// Description:
//   The accepted zero-gap reference retains the _DIRECT suffix. Positive-gap
//   names are independent of any future support implementation.
function coupon_project_name(cells_x, cells_y, clear_span, clear_gap) =
    str(
        "COUPON_", cells_x, "X", cells_y,
        "_SPAN", clear_span,
        "_GAP", clear_gap,
        clear_gap == 0 ? "_DIRECT" : ""
    );

// Function: coupon_schedule_name()
// Synopsis: Names a schedule by complete structural path-layer repetitions.
// Description:
//   XGRID1 and YGRID1 each mean one complete continuous serpentine grid layer,
//   not one individual parallel strand.
function coupon_schedule_name(clear_gap) =
    str("XGRID1_GAP", clear_gap, "_YGRID1");

// Function: coupon_schedule_clear_gap()
// Synopsis: Returns the clear Z distance between the lower and upper layers.
function coupon_schedule_clear_gap(schedule) =
    schedule[SS_GROUPS][0][PLG_CLEAR_GAP_AFTER];

// Function: coupon_boundary_supported()
// Synopsis: True only for the frozen count-driven rectangular boundary model.
function coupon_boundary_supported(boundary) =
    boundary_is_count_driven(boundary) &&
    boundary[B_KIND] == "rectangle";

// Function: coupon_pattern_supported()
// Synopsis: True only for the frozen whole-boundary square coupon topology.
function coupon_pattern_supported(pattern_set) =
    (pattern_set[PS_NAME] == "SQUARE_COUPON" &&
     len(pattern_set[PS_ZONES]) == 1)
        ? pattern_set[PS_ZONES][0][Z_PATTERN] == "square" &&
          pattern_set[PS_ZONES][0][Z_CONNECTOR] == "square_turn"
        : false;

// Function: coupon_schedule_supported()
// Synopsis: True for one lower X and one upper Y full-grid path layer.
function coupon_schedule_supported(schedule) =
    len(schedule[SS_GROUPS]) == 2
        ? schedule[SS_GROUPS][0][PLG_ORIENTATION] == 0 &&
          schedule[SS_GROUPS][1][PLG_ORIENTATION] == 90 &&
          schedule[SS_GROUPS][0][PLG_LAYER_COUNT] == 1 &&
          schedule[SS_GROUPS][1][PLG_LAYER_COUNT] == 1 &&
          schedule[SS_GROUPS][0][PLG_CLEAR_GAP_AFTER] >= 0 &&
          nearly_equal(schedule[SS_GROUPS][1][PLG_CLEAR_GAP_AFTER], 0)
        : false;

// Function: coupon_print_geometry_supported()
// Synopsis: Reports whether the current solid generator can print the case.
// Description:
//   The framework accepts positive gaps as valid specifications. Batch 009
//   intentionally leaves their support/anchor geometry as a named stub.
function coupon_print_geometry_supported(schedule) =
    nearly_equal(coupon_schedule_clear_gap(schedule), 0);

// Module: validate_rectangular_coupon_framework()
// Synopsis: Enforces the frozen rectangular coupon contract.
module validate_rectangular_coupon_framework(
    project,
    process,
    nozzle,
    boundary,
    path_policy_record,
    pattern_set_record,
    schedule
) {
    assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 1,
        "Unexpected rectangular framework version.");
    assert(coupon_boundary_supported(boundary),
        str(
            "Deferred boundary stub selected: mode=", boundary[B_MODE],
            ", kind=", boundary[B_KIND],
            ". The frozen framework supports count_boundary() rectangles only."
        ));
    assert(coupon_pattern_supported(pattern_set_record),
        str(
            "Deferred pattern stub selected: ", pattern_set_record[PS_NAME],
            ". The frozen framework supports SQUARE_COUPON only."
        ));
    assert(coupon_schedule_supported(schedule),
        "Coupon schedules require one complete X grid layer, one complete Y grid layer, and a nonnegative gap between them.");
    assert(path_policy_record[PP_REQUIRE_CONTINUOUS],
        "Coupon paths must be continuous.");
    assert(!path_policy_record[PP_ALLOW_TRAVEL] &&
           !path_policy_record[PP_ALLOW_LIFT] &&
           !path_policy_record[PP_ALLOW_CLOSED_SUBPATHS],
        "Coupon paths cannot permit travel, lift, or closed subpaths.");
    assert(path_policy_record[PP_LEAD_OUT] == 0,
        "The frozen coupon framework has one open endpoint and no lead-out.");
    assert(process[PX_WIDTH_PASSES] >= 2 &&
           process[PX_HEIGHT_PASSES] >= 2,
        "The coupon framework requires a composed structural strand.");
    assert(boundary[B_EDGE_MARGIN] == 0,
        "Calibration coupons use derived outside dimensions without a border margin.");
    assert(project[PR_PROCESS] == process[PX_NAME],
        "Project process reference does not match the resolved process.");
    assert(project[PR_BOUNDARY] == boundary[B_NAME],
        "Project boundary reference does not match the resolved boundary.");
    assert(project[PR_PATH_POLICY] == path_policy_record[PP_NAME],
        "Project path-policy reference does not match the resolved policy.");
    assert(project[PR_PATTERN_SET] == pattern_set_record[PS_NAME],
        "Project pattern reference does not match the resolved pattern.");
    assert(project[PR_SCHEDULE] == schedule[SS_NAME],
        "Project schedule reference does not match the resolved schedule.");
    assert(nozzle[NZ_DIAMETER] > 0,
        "The resolved nozzle diameter must be positive.");

    echo("GRID STACK RECTANGULAR FRAMEWORK VALIDATION: PASS");
}

// Module: assert_coupon_print_geometry_supported()
// Synopsis: Stops positive-gap rendering at the explicit Batch 009 stub.
module assert_coupon_print_geometry_supported(schedule) {
    clear_gap = coupon_schedule_clear_gap(schedule);

    assert(coupon_print_geometry_supported(schedule),
        str(
            "Vertical-gap geometry stub: ", clear_gap,
            " mm is a valid frozen coupon specification, but printable anchor/support geometry is reserved for the next batch."
        ));
}
