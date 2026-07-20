//////////////////////////////////////////////////////////////////////
// LibFile: nozzles.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Catalog of installed nozzle hardware dimensions.
// Role: Records the physical trace-width basis. Changing nozzle diameter
//       creates a different process environment and requires a new profile.
// Requires: nozzle_spec() from lib/schema.scad, loaded first by main.scad.
// Exports: NOZZLES
//////////////////////////////////////////////////////////////////////

NOZZLES = [
    nozzle_spec(
        name = "BRASS_0P4",
        diameter = 0.4,
        construction = "brass",
        status = "in_use",
        notes = "Only nozzle currently qualified for Grid Stack."
    )
];
