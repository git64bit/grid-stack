# Saved-Object Contract

## Definition

A saved Grid Stack object is one top-level `.scad` recipe committed with the Grid Stack source that generated it.

## Required properties

A permanent recipe must:

- import an explicit file under `api/`;
- assert its required API version;
- declare an object-schema version;
- embed all geometry-affecting records;
- avoid Customizer state and mutable catalog lookup;
- call exactly one public execution module;
- receive a new filename and revision when altered after printing.

## Version layers

### API version

Controls the public constructors, record meaning, validation behavior, and execution entry point. An incompatible public change requires a new API version.

### Object-schema version

Controls the field layout and meaning of `grid_stack_object()` records.

### Release

Identifies a documented project release such as `0.5.0`.

### Git commit or tag

Identifies the exact source implementation. This is the authoritative mechanism for reproducing historical behavior.

## Import choices

Use the current alias only for new development:

```scad
include <grid_stack.scad>
```

Use an explicit version for permanent recipes:

```scad
include <../api/grid_stack_v1.scad>
assert(GRID_STACK_API_VERSION == 1);
```

## Catalog isolation

Configuration catalogs are convenient for exploration, but they may expand or receive new revisions. A saved object therefore embeds exact material, nozzle, process, boundary, path, pattern, and schedule records.

## First-layer recipes

Single-layer trace recipes use `first_layer_object()` and assert both:

```scad
assert(GRID_STACK_API_VERSION == 1);
assert(GRID_STACK_FIRST_LAYER_SCHEMA_VERSION == 1);
```

They embed explicit parallel-trace records in addition to the qualified material, nozzle, and process environment. Their single execution call is `first_layer_render()`.
