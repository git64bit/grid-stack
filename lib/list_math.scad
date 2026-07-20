//////////////////////////////////////////////////////////////////////
// LibFile: list_math.scad
// Project: Grid Stack
// FileGroup: Utilities
// FileSummary: Small list, schedule, and derived-gap helpers.
// Role: Supplies pure functions with no configuration lookup or geometry.
// Requires: Field indexes and process_math.scad loaded by main.scad.
// Exports: Summation, reversal, schedule, and clear-gap functions.
//////////////////////////////////////////////////////////////////////

function sum_values(values, index = 0) =
    index >= len(values) ? 0 : values[index] + sum_values(values, index + 1);

function nearly_equal(a, b, tolerance = 0.0001) = abs(a - b) <= tolerance;

function is_integer_value(value) = nearly_equal(value, round(value));

function reversed(values) =
    len(values) == 0 ? [] :
    [for (index = [len(values) - 1 : -1 : 0]) values[index]];

function total_scheduled_layers(schedule) =
    sum_values([for (group = schedule[LS_GROUPS]) group[LG_COUNT]]);

function scheduled_height(schedule, process) =
    sum_values([
        for (group = schedule[LS_GROUPS])
            group[LG_COUNT] * process[PX_LAYER_H] * group[LG_Z_STEP_MULTIPLIER]
    ]);

function zone_clear_gap(zone, process, nozzle) =
    zone[Z_STRAND_PITCH] - strand_width(process, nozzle);
