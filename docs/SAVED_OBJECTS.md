# Saved-Object Contract

## Definition

A saved Grid Stack object is one top-level `.scad` recipe committed with the Grid Stack source that generated it.

## Required properties

A permanent recipe must:

- import an explicit file under `api/`;
- assert its required API version;
- declare an object-schema version;
- embed all geometry-affecting records;
- record its source release and accepted source commit;
- avoid Customizer state and mutable catalog lookup;
- call exactly one public execution module;
- receive a new filename and revision when altered after printing.

## Version layers

### API version

Controls the public constructors, record meaning, validation behavior, and execution entry point. An incompatible public change requires a new API file.

### Object-schema version

Controls the field layout and meaning of a saved object record.

### Release

Identifies a documented project release such as `0.7.0`.

### Git commit or tag

Identifies the exact source implementation. This is the authoritative mechanism for reproducing historical behavior.

## API version 1

Existing stack/coupon and first-layer records use:

```scad
include <../api/grid_stack_v1.scad>
assert(GRID_STACK_API_VERSION == 1);
```

API v1 first-layer objects reuse the structural `process_profile()` record.

## API version 2

Immutable printed first-layer objects use:

```scad
include <../../api/grid_stack_v2.scad>
assert(GRID_STACK_API_VERSION == 2);
assert(GRID_STACK_FIRST_LAYER_SCHEMA_VERSION == 2);
```

API v2 introduces:

- `printer_spec()`;
- `trace_process_profile()`;
- source-commit storage inside `first_layer_object()`.

A primitive trace process does not contain structural width passes, structural height passes, or bridge limits.

## Catalog isolation

Configuration catalogs are convenient for exploration, but they may expand or receive new revisions. A saved object embeds exact records rather than resolving mutable catalog names.

## Missing historical information

Do not guess. The Batch 007 PLA+ and TPU recipes record the printer as `UNRECORDED_PRINTER_R1` because the machine details were not supplied. Future recipes should record the actual printer and build surface.
