//////////////////////////////////////////////////////////////////////
// LibFile: path_policies.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Shared and laboratory continuity, lead-in, and endpoint policies.
// Role: Supplies declarative records; it does not generate geometry.
// Requires: path_policy() from lib/schema.scad, loaded first by main.scad.
// Exports: BASE_PATH_POLICIES, ACTIVE_LABORATORY_PATH_POLICIES, PATH_POLICIES
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


ACTIVE_LABORATORY_PATH_POLICIES = is_undef(LABORATORY_PATH_POLICIES)
    ? []
    : LABORATORY_PATH_POLICIES;

PATH_POLICIES = concat(
    BASE_PATH_POLICIES,
    ACTIVE_LABORATORY_PATH_POLICIES
);
