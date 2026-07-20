//////////////////////////////////////////////////////////////////////
// LibFile: coupon_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Expands a coupon series into its complete span-by-gap matrix.
// Role: Makes every planned coupon dimension and qualification status visible.
// Requires: Catalogs, lookup, boundary math, stack math, and process math.
// Exports: report_coupon_series().
//////////////////////////////////////////////////////////////////////

function bridge_case_status(clear_span, process) =
    clear_span <= process[PX_BRIDGE_MAX]
        ? "within_current_limit"
        : "exploratory_beyond_limit";

module report_coupon_series(series) {
    process = named_record(PROCESS_PROFILES, series[CS_PROCESS], "process profile");
    nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");

    echo("============================================================");
    echo(str("Coupon series: ", series[CS_NAME]));
    echo(str("Cases: ",
        len(series[CS_BOUNDARIES]) * len(series[CS_SCHEDULES])));
    echo("Each row: [boundary, schedule, clear span, vertical gap, size X, size Y, stack height, status]");

    for (boundary_name = series[CS_BOUNDARIES]) {
        boundary = named_record(BOUNDARIES, boundary_name, "boundary");

        for (schedule_name = series[CS_SCHEDULES]) {
            schedule = named_record(STACK_SCHEDULES, schedule_name, "stack schedule");
            echo([
                boundary[B_NAME],
                schedule[SS_NAME],
                boundary[B_CLEAR_SPAN_X],
                scheduled_clear_height(schedule),
                boundary_size_x(boundary, process, nozzle),
                boundary_size_y(boundary, process, nozzle),
                scheduled_height(schedule, process),
                bridge_case_status(boundary[B_CLEAR_SPAN_X], process)
            ]);
        }
    }

    echo("============================================================");
}
