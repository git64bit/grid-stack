//////////////////////////////////////////////////////////////////////
// LibFile: alternating_grid_stack.scad
// Project: Grid Stack
// FileGroup: Printable Geometry
// FileSummary: Stacks any positive number of equal-height deposited grid
//              layers while alternating X- and Y-running paths.
// Role: Implements the mutable laboratory panel without changing the frozen
//       structural-coupon geometry or its versioned saved-object APIs.
// Requires: rectangular_grid_path(), process_math.scad, and
//           square_trace_path_2d() from trace_layer.scad.
// Exports: deposited_grid_layer_orientation(),
//          printable_structural_trace_layer_path(), and
//          printable_alternating_grid_stack().
//////////////////////////////////////////////////////////////////////

// Function: deposited_grid_layer_orientation()
// Synopsis: Returns 0 or 90 degrees for one alternating deposited layer.
function deposited_grid_layer_orientation(layer_index, first_orientation = 0) =
    assert(layer_index >= 0 && is_integer_value(layer_index),
        "Deposited grid-layer index must be a nonnegative integer.")
    assert(first_orientation == 0 || first_orientation == 90,
        "First deposited grid-layer orientation must be 0 or 90 degrees.")
    (layer_index % 2 == 0)
        ? first_orientation
        : 90 - first_orientation;

// Module: printable_structural_trace_layer_path()
// Synopsis: Renders one deposited layer using the qualified composed width.
// Description:
//   Width is still nozzle diameter times the qualified horizontal pass count.
//   Height is exactly one qualified deposited layer. Repetition in Z is
//   controlled by printable_alternating_grid_stack().
module printable_structural_trace_layer_path(points, process, nozzle) {
    composed_width = strand_width(process, nozzle);
    deposited_height = trace_height(process);

    assert(process[PX_WIDTH_PASSES] >= 2,
        "A Grid Stack deposited path requires at least two width passes.");
    assert(process[PX_HEIGHT_PASSES] >= 2,
        "The qualified process must retain at least two height passes.");
    assert(composed_width > 0 && deposited_height > 0,
        "Deposited grid-layer dimensions must be positive.");

    linear_extrude(height = deposited_height, convexity = 10)
        square_trace_path_2d(points, composed_width);
}

// Module: printable_alternating_grid_stack()
// Synopsis: Renders an equal-height X/Y/X/Y deposited-layer stack.
// Arguments:
//   boundary = Active rectangular count boundary.
//   process = Qualified Grid Stack process profile.
//   nozzle = Qualified nozzle record.
//   deposited_layer_count = Number of physical deposited layers.
//   first_orientation = 0 for X first or 90 for Y first.
//   lead_in = External lead-in used by the first deposited layer only.
// Description:
//   Every layer is one continuous open path. Later layers start at the shared
//   lower-left grid crossing, avoiding an unsupported repeated lead-in.
module printable_alternating_grid_stack(
    boundary,
    process,
    nozzle,
    deposited_layer_count,
    first_orientation = 0,
    lead_in = 0
) {
    deposited_height = trace_height(process);

    assert(deposited_layer_count >= 1 &&
           is_integer_value(deposited_layer_count),
        "Deposited grid-layer count must be a positive integer.");
    assert(first_orientation == 0 || first_orientation == 90,
        "First deposited grid-layer orientation must be 0 or 90 degrees.");
    assert(lead_in >= 0,
        "Laboratory grid lead-in cannot be negative.");

    union() {
        for (layer_index = [0 : deposited_layer_count - 1]) {
            orientation = deposited_grid_layer_orientation(
                layer_index,
                first_orientation
            );
            points = rectangular_grid_path(
                boundary,
                process,
                nozzle,
                orientation,
                layer_index == 0 ? lead_in : 0
            );

            translate([0, 0, layer_index * deposited_height])
                printable_structural_trace_layer_path(
                    points,
                    process,
                    nozzle
                );
        }
    }
}
