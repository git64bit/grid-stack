
# Architecture

## Environment layer

The environment is resolved before any geometry:

```text
materials + nozzles → qualified process profile → derived strand dimensions
```

Material and nozzle catalogs describe identity. A process profile records the tested combination and revision.

## Project layer

Projects reference one exact process profile plus boundary, path, pattern, and schedule records.

## Schema and indexes

`lib/schema.scad` centralizes vector construction. `lib/indices.scad` names every field position.

## Lookup, validation, and reporting

Lookup requires exactly one matching record. Validation rejects incomplete environments. Reporting exposes the resolved values before geometry is attempted.

## Future path and geometry layers

`paths/` will create ordered centerline data. `geometry/` will convert accepted paths to printable solids using derived strand dimensions. Neither layer should own material or nozzle constants.
