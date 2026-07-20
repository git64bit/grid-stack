//////////////////////////////////////////////////////////////////////
// LibFile: list_math.scad
// Project: Grid Stack
// FileGroup: Utilities
// FileSummary: Small pure list and numeric helpers.
// Role: Supplies generic operations with no configuration lookup or geometry.
// Exports: sum_values(), nearly_equal(), is_integer_value(), reversed().
//////////////////////////////////////////////////////////////////////

function sum_values(values, index = 0) =
    index >= len(values) ? 0 : values[index] + sum_values(values, index + 1);

function nearly_equal(a, b, tolerance = 0.0001) = abs(a - b) <= tolerance;

function is_integer_value(value) = nearly_equal(value, round(value));

function reversed(values) =
    len(values) == 0 ? [] :
    [for (index = [len(values) - 1 : -1 : 0]) values[index]];
