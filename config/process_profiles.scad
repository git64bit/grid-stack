//////////////////////////////////////////////////////////////////////
// LibFile: process_profiles.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Qualified combinations of material, nozzle, layer height,
//              structural pass counts, and observed bridge behavior.
// Role: Defines the reproducible project environment. Existing profiles are
//       historical records; create a new named profile when any input changes.
// Requires: process_profile() from lib/schema.scad, loaded first by main.scad.
// Exports: PROCESS_PROFILES
//////////////////////////////////////////////////////////////////////

PROCESS_PROFILES = [
    process_profile(
        name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        material_name = "PLA_PLUS",
        nozzle_name = "BRASS_0P4",
        layer_height = 0.2,
        width_passes = 2,
        height_passes = 2,
        bridge_max = 6.0,
        qualification = "owner_tested",
        revision = 1,
        notes = "Reference environment: two adjacent traces form a 0.8 mm strand; two deposited layers form a 0.4 mm strand height."
    )
];
