//////////////////////////////////////////////////////////////////////
// LibFile: path_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Prints the ordered path points and basic path measurements.
// Role: Makes the generated centerline auditable before slicer use.
// Requires: Path and boundary math plus field indexes.
// Exports: report_generated_path().
//////////////////////////////////////////////////////////////////////

module report_generated_path(points, boundary, process, nozzle, orientation) {
    run_count = orientation == 0
        ? boundary_strand_count_y(boundary)
        : boundary_strand_count_x(boundary);
    connector_count = run_count - 1;

    echo("---------------- GENERATED PATH ----------------");
    echo(str("Orientation: ", orientation, " degrees"));
    echo(str("Continuous paths: 1"));
    echo(str("Parallel runs: ", run_count));
    echo(str("Square connectors: ", connector_count));
    echo(str("Ordered points: ", len(points)));
    echo(str("Centerline length: ", path_length(points), " mm"));
    echo(str("Start point: ", path_start(points)));
    echo(str("End point: ", path_end(points)));
    echo("Point order:");
    for (i = [0 : len(points) - 1])
        echo([i, points[i]]);
    echo("------------------------------------------------");
}
