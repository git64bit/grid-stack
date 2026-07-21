//////////////////////////////////////////////////////////////////////
// LibFile: coupon_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Expands the frozen span-by-gap coupon matrix and reports the
//              separate accepted direct-contact reference.
// Role: Makes every coupon dimension, qualification status, support strategy,
//       and print implementation status visible without creating geometry.
// Requires: Catalogs, lookup, boundary math, stack math, and framework math.
// Exports: bridge_case_status() and report_coupon_series().
//////////////////////////////////////////////////////////////////////

function bridge_case_status(clear_span, process) =
    clear_span <= process[PX_BRIDGE_MAX]
        ? "within_owner_tested_limit"
        : "exploratory_beyond_owner_tested_limit";

module report_coupon_series(series) {
    process = named_record(PROCESS_PROFILES, series[CS_PROCESS], "process profile");
    nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");

    echo("============================================================");
    echo(str("Coupon series: ", series[CS_NAME]));
    echo(str("Positive-gap cases: ",
        len(series[CS_BOUNDARIES]) * len(series[CS_SCHEDULES])));
    echo(str("Direct-contact reference project: ",
        DIRECT_CONTACT_REFERENCE_PROJECT));
    echo("Each row: [boundary, schedule, XY span, Z gap, size X, size Y, stack height, span status, support strategy, geometry status]");

    for (boundary_name = series[CS_BOUNDARIES]) {
        boundary = named_record(BOUNDARIES, boundary_name, "boundary");

        for (schedule_name = series[CS_SCHEDULES]) {
            schedule = named_record(STACK_SCHEDULES, schedule_name, "stack schedule");
            clear_gap = coupon_schedule_clear_gap(schedule);
            echo([
                boundary[B_NAME],
                schedule[SS_NAME],
                boundary[B_CLEAR_SPAN_X],
                clear_gap,
                boundary_size_x(boundary, process, nozzle),
                boundary_size_y(boundary, process, nozzle),
                scheduled_height(schedule, process),
                bridge_case_status(boundary[B_CLEAR_SPAN_X], process),
                coupon_support_strategy(schedule),
                coupon_print_geometry_supported(schedule, process)
                    ? "implemented"
                    : "invalid_layer_quantization"
            ]);
        }
    }

    echo("============================================================");
}
