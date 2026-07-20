//////////////////////////////////////////////////////////////////////
// LibFile: boundary_math.scad
// Project: Grid Stack
// FileGroup: Boundary Mathematics
// FileSummary: Derives count-driven dimensions and names without geometry.
// Role: Keeps grid-count formulas centralized and process-aware.
// Requires: Field indexes and process_math.scad.
// Exports: Boundary mode, count, pitch, span, and outside-size helpers.
//////////////////////////////////////////////////////////////////////

function count_boundary_name(cells_x, cells_y, clear_span) =
    str("COUNT_", cells_x, "X", cells_y, "_SPAN", clear_span);

function boundary_is_dimension_driven(boundary) =
    boundary[B_MODE] == "dimension";

function boundary_is_count_driven(boundary) =
    boundary[B_MODE] == "count";

function boundary_strand_count_x(boundary) =
    boundary[B_CELLS_X] + 1;

function boundary_strand_count_y(boundary) =
    boundary[B_CELLS_Y] + 1;

function boundary_strand_pitch_x(boundary, process, nozzle) =
    boundary[B_CLEAR_SPAN_X] + strand_width(process, nozzle);

function boundary_strand_pitch_y(boundary, process, nozzle) =
    boundary[B_CLEAR_SPAN_Y] + strand_width(process, nozzle);

function count_boundary_dimension(
    cell_count, clear_span, composed_strand_width, edge_margin = 0
) =
    cell_count * clear_span +
    (cell_count + 1) * composed_strand_width +
    2 * edge_margin;

function boundary_size_x(boundary, process, nozzle) =
    boundary_is_dimension_driven(boundary)
        ? boundary[B_SIZE_X]
        : count_boundary_dimension(
            boundary[B_CELLS_X],
            boundary[B_CLEAR_SPAN_X],
            strand_width(process, nozzle),
            boundary[B_EDGE_MARGIN]
        );

function boundary_size_y(boundary, process, nozzle) =
    boundary_is_dimension_driven(boundary)
        ? boundary[B_SIZE_Y]
        : count_boundary_dimension(
            boundary[B_CELLS_Y],
            boundary[B_CLEAR_SPAN_Y],
            strand_width(process, nozzle),
            boundary[B_EDGE_MARGIN]
        );
