# Batch 005 — Versioned Saved-Object API

Base commit: `815a305`

Batch 005 pauses printable-geometry work and establishes how a Grid Stack object is permanently saved.

## Added

- `grid_stack.scad` as the current public-interface alias;
- `api/grid_stack_v1.scad` as the explicit versioned API import;
- `GRID_STACK_API_VERSION = 1`;
- `GRID_STACK_OBJECT_SCHEMA_VERSION = 1`;
- `grid_stack_object()` as the self-contained saved-object record;
- `grid_stack_render()` as the single public execution module;
- saved-object validation and reporting;
- `objects/coupon_3x3_span6_gap2_v1.scad` as the first permanent recipe example.

## Deliberately unchanged

- no printable structural-strand geometry;
- no stack solid generation;
- no new path topology;
- no Customizer-to-file automation.

## Compatibility rule

Permanent recipes import `api/grid_stack_v1.scad` and assert API version 1. A future incompatible interface must be added as a new versioned API file. The exact historical implementation is the Git commit or tag containing the recipe.
