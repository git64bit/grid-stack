//////////////////////////////////////////////////////////////////////
// LibFile: parallel_trace_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies the exact ordered path produced by the reference
//              variable-length, variable-repeat parallel-trace sequence.
// Role: Locks the meaning of [axis_min, axis_max, perpendicular_position].
// Requires: Grid Stack API version 1.
// Output: Console assertions only; no geometry.
//////////////////////////////////////////////////////////////////////

include <../api/grid_stack_v1.scad>

traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];

expected_without_lead_in = [
    [-10,  0],
    [ 10,  0],
    [ 10,  5],
    [ -8,  5],
    [ -8, 15],
    [  3, 15],
    [  3, 16],
    [ -6, 16],
    [ -6, 18],
    [  9, 18]
];

expected_with_lead_in = concat([[-40, 0]], expected_without_lead_in);
actual = parallel_trace_path(traces, orientation = 0, lead_in = 30);

assert(actual == expected_with_lead_in,
    "Parallel-trace path no longer matches the version-1 contract.");
assert(parallel_trace_lengths(traces) == [20, 18, 11, 9, 15],
    "Parallel-trace lengths changed unexpectedly.");
assert(trace_repeat_distances(traces) == [5, 10, 1, 2],
    "Parallel-trace repeat distances changed unexpectedly.");
clear_gaps = trace_clear_gaps(traces, 0.4);
assert(nearly_equal(clear_gaps[0], 4.6) &&
       nearly_equal(clear_gaps[1], 9.6) &&
       nearly_equal(clear_gaps[2], 0.6) &&
       nearly_equal(clear_gaps[3], 1.6),
    "Parallel-trace clear gaps changed unexpectedly.");

echo("GRID STACK PARALLEL TRACE CONTRACT: PASS");
