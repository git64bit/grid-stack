//////////////////////////////////////////////////////////////////////
// LibFile: lookup.scad
// Project: Grid Stack
// FileGroup: Utilities
// FileSummary: Resolves one stable record name to exactly one record.
// Role: Converts project references into concrete environment and policy data.
// Exports: records_named(), named_record(), record_names().
//////////////////////////////////////////////////////////////////////

function records_named(records, name) =
    [for (record = records) if (record[0] == name) record];

function named_record(records, name, record_kind = "record") =
    let(matches = records_named(records, name))
    assert(
        len(matches) == 1,
        str(
            "Expected exactly one ", record_kind,
            " named '", name, "'; found ", len(matches), "."
        )
    )
    matches[0];

function record_names(records) = [for (record = records) record[0]];
