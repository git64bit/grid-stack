//////////////////////////////////////////////////////////////////////
// LibFile: stack_math.scad
// Project: Grid Stack
// FileGroup: Stack Mathematics
// FileSummary: Expands structural path-layer schedules into raw deposited
//              layers, material height, clear Z gaps, and total stack height.
// Role: Preserves schedule meaning when nozzle, layer height, or process pass
//       composition changes.
// Requires: Field indexes, list_math.scad, and process_math.scad.
// Exports: Legacy and frozen naming helpers, path-layer counts, deposited-layer
//          counts, material height, clear height, and total height.
//////////////////////////////////////////////////////////////////////

// Function: gap_schedule_name()
// Synopsis: Compatibility name retained for API v1 saved records.
function gap_schedule_name(clear_gap) =
    str("X1_GAP", clear_gap, "_Y1");

// Function: deposited_layers_in_group()
// Synopsis: Raw slicer layers required by all full path layers in a group.
function deposited_layers_in_group(group, process) =
    group[PLG_LAYER_COUNT] * process[PX_HEIGHT_PASSES];

// Function: material_height_in_group()
// Synopsis: Physical material height contributed by one path-layer group.
function material_height_in_group(group, process) =
    group[PLG_LAYER_COUNT] * strand_height(process);

// Function: total_scheduled_path_layers()
// Synopsis: Number of complete continuous grid layers in the schedule.
function total_scheduled_path_layers(schedule) =
    sum_values([
        for (group = schedule[SS_GROUPS]) group[PLG_LAYER_COUNT]
    ]);

// Function: total_scheduled_strands()
// Synopsis: Compatibility alias for the corrected path-layer count.
function total_scheduled_strands(schedule) =
    total_scheduled_path_layers(schedule);

function total_scheduled_layers(schedule, process) =
    sum_values([
        for (group = schedule[SS_GROUPS])
            deposited_layers_in_group(group, process)
    ]);

function scheduled_material_height(schedule, process) =
    sum_values([
        for (group = schedule[SS_GROUPS])
            material_height_in_group(group, process)
    ]);

function scheduled_clear_height(schedule) =
    sum_values([
        for (group = schedule[SS_GROUPS]) group[PLG_CLEAR_GAP_AFTER]
    ]);

function scheduled_height(schedule, process) =
    scheduled_material_height(schedule, process) +
    scheduled_clear_height(schedule);
