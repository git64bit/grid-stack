# Architecture

## Two top-level uses

### Development workbench

`main.scad` performs catalog-driven orchestration:

1. load the current public API;
2. load Customizer selectors and configuration catalogs;
3. resolve named records;
4. validate and report the selected environment;
5. delegate to diagnostic path generation.

It is intended for exploration and development, not permanent object storage.

### Saved-object recipe

A file under `objects/`:

1. imports an explicit versioned API file;
2. asserts the required API version;
3. constructs exact embedded records;
4. builds one `grid_stack_object()` record;
5. calls one `grid_stack_render()` module.

It does not read Customizer state or mutable configuration catalogs.

## Public API layer

`grid_stack.scad` is the current convenience alias for new development.

`api/grid_stack_v1.scad` is the explicit stable import for API version 1. It loads the public constructors, mathematics, validation, reporting, existing path generator, and diagnostic display.

An incompatible public change requires a new API file. Existing versioned API imports remain available for saved recipes.

## Configuration layer

`config/` contains mutable declarative catalogs used by `main.scad`:

- material identities;
- nozzle hardware;
- qualified process environments;
- dimension and count boundaries;
- path policies;
- pattern topology and spacing source;
- structural-strand stack schedules;
- coupon matrices;
- project references.

Configuration files do not generate geometry.

## Library layer

`lib/` contains:

- record constructors and field indexes;
- named lookup;
- process, boundary, pattern, path, and stack mathematics;
- development validation and reporting;
- saved-object validation and reporting.

Pure math files do not depend on project selections.

## Generation layers

`paths/` constructs ordered continuous centerlines. The first implementation is the rectangular coupon serpentine.

`geometry/` currently displays validated paths. Printable structural-strand conversion remains future work.

`tests/` will expose printable calibration outputs after stack generation.

## Dependency direction

```text
main.scad ───────────────┐
                         ↓
objects/*.scad → versioned public API
                         ↓
        constructors, indexes, validation, pure math
                         ↓
              ordered path generation
                         ↓
          diagnostic or future solid output
```

Dependencies must not point upward. A generic library must not select a project or read Customizer variables.

## First-layer execution path

```text
first-layer-0u2Z-anyXY.scad
        ↓
first_layer_object()
        ↓
validate_parallel_traces()
        ↓
parallel_trace_path()
        ↓
printable_trace_layer()
```

The record layer describes independently sized and positioned parallel traces. The path layer determines traversal and connectors. The geometry layer applies nozzle trace width and deposited-layer height.
