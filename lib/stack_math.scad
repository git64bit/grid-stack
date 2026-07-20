//////////////////////////////////////////////////////////////////////
// LibFile: stack_math.scad
// Project: Grid Stack
// FileGroup: Stack Mathematics
// FileSummary: Expands structural-strand schedules into deposited layers,
//              material height, clear vertical gaps, and total stack height.
// Role: Preserves schedule meaning when nozzle or layer height changes.
// Requires: Field indexes, list_math.scad, and process_math.scad.
// Exports: Schedule naming, counts, and height functions.
//////////////////////////////////////////////////////////////////////

function gap_schedule_name(clear_gap) =
    str("X1_GAP", clear_gap, "_Y1");

function deposited_layers_in_group(group, process) =
    group[SG_STRAND_COUNT] * process[PX_HEIGHT_PASSES];

function material_height_in_group(group, process) =
    group[SG_STRAND_COUNT] * strand_height(process);

function total_scheduled_strands(schedule) =
    sum_values([
        for (group = schedule[SS_GROUPS]) group[SG_STRAND_COUNT]
    ]);

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
        for (group = schedule[SS_GROUPS]) group[SG_CLEAR_GAP_AFTER]
    ]);

function scheduled_height(schedule, process) =
    scheduled_material_height(schedule, process) +
    scheduled_clear_height(schedule);
