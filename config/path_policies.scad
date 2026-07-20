PATH_POLICIES = [
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
