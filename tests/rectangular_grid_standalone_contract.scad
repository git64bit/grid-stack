//////////////////////////////////////////////////////////////////////
// LibFile: rectangular_grid_standalone_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies that the active rectangular-grid path generator has no
//              dependency on API v1 rectangular-serpentine include order.
//////////////////////////////////////////////////////////////////////

include <../lib/indices.scad>
include <../lib/schema.scad>
include <../lib/process_math.scad>
include <../lib/boundary_math.scad>
include <../paths/rectangular_grid.scad>

test_nozzle = nozzle_spec(
    name = "TEST_0P4",
    diameter = 0.4,
    construction = "test",
    status = "in_use"
);

test_process = process_profile(
    name = "TEST_PROCESS",
    material_name = "TEST_MATERIAL",
    nozzle_name = "TEST_0P4",
    layer_height = 0.2,
    width_passes = 2,
    height_passes = 2,
    bridge_max = 0,
    qualification = "test",
    revision = 1
);

test_boundary = count_boundary(
    name = "TEST_2X3",
    cells_x = 2,
    cells_y = 3,
    clear_span_x = 5,
    clear_span_y = 6
);

x_path = rectangular_grid_path(
    test_boundary, test_process, test_nozzle, 0, 10
);
y_path = rectangular_grid_path(
    test_boundary, test_process, test_nozzle, 90, 10
);

assert(
    len(x_path) == expected_rectangular_grid_point_count(
        boundary_strand_count_y(test_boundary), 10
    ),
    "X-running standalone path has an unexpected point count."
);
assert(
    len(y_path) == expected_rectangular_grid_point_count(
        boundary_strand_count_x(test_boundary), 10
    ),
    "Y-running standalone path has an unexpected point count."
);
assert(x_path[0][0] < x_path[1][0] && x_path[0][1] == x_path[1][1],
    "X-running lead-in must approach the boundary horizontally.");
assert(y_path[0][1] < y_path[1][1] && y_path[0][0] == y_path[1][0],
    "Y-running lead-in must approach the boundary vertically.");

echo("GRID STACK RECTANGULAR GRID STANDALONE CONTRACT: PASS");
