//////////////////////////////////////////////////////////////////////
// LibFile: path_policies.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: One-path policies used by configurable workbenches.
//////////////////////////////////////////////////////////////////////

BASE_PATH_POLICIES = [
    path_policy(
        name = "ONE_PATH_WITH_LEAD_IN",
        lead_in = 30,
        lead_out = 0,
        require_continuous = true,
        allow_travel = false,
        allow_lift = false,
        allow_closed_subpaths = false,
        start_rule = "lead_in_starts_outside_boundary",
        end_rule = "single_open_end",
        notes = "Exactly one open nozzle path per deposited layer."
    )
];

ACTIVE_CONFIGURABLE_PATH_POLICIES = is_undef(CONFIGURABLE_GRID_PATH_POLICIES)
    ? [] : CONFIGURABLE_GRID_PATH_POLICIES;

PATH_POLICIES = concat(BASE_PATH_POLICIES, ACTIVE_CONFIGURABLE_PATH_POLICIES);
