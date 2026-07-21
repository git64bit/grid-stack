//////////////////////////////////////////////////////////////////////
// LibFile: coupon_framework.scad
// Project: Grid Stack
// FileGroup: Framework Contract
// FileSummary: Freezes the supported rectangular count-boundary coupon model,
//              including direct-contact and positive vertical-gap geometry.
// Role: Provides one validation and naming contract shared by the workbench,
//       contract tests, and immutable coupon API version 3.
// Requires: Field indexes, boundary/process/path/stack mathematics, and
//           nearly_equal() from list_math.scad.
// Exports: Framework version, coupon naming helpers, support predicates,
//          validation, and deliberate deferred-feature assertions.
//////////////////////////////////////////////////////////////////////

GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION = 2;

// Function: coupon_project_name()
// Synopsis: Returns the canonical project name for one coupon specification.
function coupon_project_name(cells_x, cells_y, clear_span, clear_gap) =
    str(
        "COUPON_", cells_x, "X", cells_y,
        "_SPAN", clear_span,
        "_GAP", clear_gap,
        clear_gap == 0 ? "_DIRECT" : ""
    );

// Function: coupon_schedule_name()
// Synopsis: Names a schedule by complete structural path-layer repetitions.
function coupon_schedule_name(clear_gap) =
    clear_gap == 0
        ? "XGRID1_GAP0_YGRID1"
        : str("YWITNESS1_GAP", clear_gap, "_YTEST1_RISERX");

// Function: coupon_schedule_clear_gap()
// Synopsis: Returns the clear Z distance requested by the schedule.
function coupon_schedule_clear_gap(schedule) =
    schedule[SS_GROUPS][0][PLG_CLEAR_GAP_AFTER];

// Function: coupon_gap_layer_count()
// Synopsis: Returns the raw deposited-layer count spanning the clear gap.
function coupon_gap_layer_count(schedule, process) =
    coupon_schedule_clear_gap(schedule) / trace_height(process);

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
// Synopsis: True for one lower and one upper complete path-layer declaration.
function coupon_schedule_supported(schedule) =
    len(schedule[SS_GROUPS]) == 2
        ? let(
            lower = schedule[SS_GROUPS][0],
            upper = schedule[SS_GROUPS][1],
            gap = lower[PLG_CLEAR_GAP_AFTER],
            orientations_valid = nearly_equal(gap, 0)
                ? lower[PLG_ORIENTATION] == 0 &&
                  upper[PLG_ORIENTATION] == 90
                : lower[PLG_ORIENTATION] == 90 &&
                  upper[PLG_ORIENTATION] == 90
          )
          orientations_valid &&
          lower[PLG_LAYER_COUNT] == 1 &&
          upper[PLG_LAYER_COUNT] == 1 &&
          gap >= 0 &&
          nearly_equal(upper[PLG_CLEAR_GAP_AFTER], 0)
        : false;

// Function: coupon_print_geometry_supported()
// Synopsis: True when the gap is printable as a whole deposited-layer count.
function coupon_print_geometry_supported(schedule, process) =
    coupon_schedule_supported(schedule) &&
    nearly_equal(
        coupon_gap_layer_count(schedule, process),
        round(coupon_gap_layer_count(schedule, process))
    );

// Function: coupon_support_strategy()
// Synopsis: Selects the frozen geometry strategy from the requested gap.
function coupon_support_strategy(schedule) =
    nearly_equal(coupon_schedule_clear_gap(schedule), 0)
        ? "direct_orthogonal"
        : "witness_riser_bridge";

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
    assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 2,
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
        "Direct schedules require X then Y; positive-gap schedules require aligned Y witness/test groups and a nonnegative gap.");
    assert(coupon_print_geometry_supported(schedule, process),
        str(
            "Clear gap must be a whole deposited-layer count: ",
            coupon_schedule_clear_gap(schedule), " / ", trace_height(process)
        ));
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
// Synopsis: Stops any gap not representable by complete deposited layers.
module assert_coupon_print_geometry_supported(schedule, process) {
    assert(coupon_print_geometry_supported(schedule, process),
        str(
            "Unsupported coupon gap: ", coupon_schedule_clear_gap(schedule),
            " mm at ", trace_height(process), " mm deposited layers."
        ));
}
