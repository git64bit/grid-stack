/* All configuration tables use the record name at index zero. */

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
