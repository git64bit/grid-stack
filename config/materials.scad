//////////////////////////////////////////////////////////////////////
// LibFile: materials.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Catalog of filament material identities used by process profiles.
// Role: Describes material families only. Hardware dimensions and tested
//       printing behavior belong in nozzle and process-profile records.
// Requires: material_spec() from lib/schema.scad, loaded first by main.scad.
// Exports: MATERIALS
//////////////////////////////////////////////////////////////////////

MATERIALS = [
    material_spec(
        name = "PLA_PLUS",
        family = "PLA+",
        flexibility = "rigid",
        status = "in_use",
        notes = "Current rigid material family. Manufacturer variation remains possible and is qualified through process profiles."
    ),

    material_spec(
        name = "TPU",
        family = "TPU",
        flexibility = "flexible",
        status = "in_use",
        notes = "Current flexible material family. No Grid Stack bridge process is qualified yet."
    )
];
