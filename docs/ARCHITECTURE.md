# Architecture

## Workbench routing

Each executable wrapper defines Customizer-visible values and includes `main.scad`.

```text
Customizer wrapper
        ↓
config/defaults.scad resolves stable parameter names
        ↓
workbench registry selects one project
        ↓
shared validation, reporting, paths, and geometry
```

The wrappers are:

```text
workbenches/coupons.scad
workbenches/laboratory.scad
workbenches/first-layer.scad
workbenches/catalog.scad
```

`default.scad` is the maintainer-oriented development wrapper.

## Configurable rectangular grid

Coupon and Laboratory presets share one fixed engine:

```text
CONFIGURABLE_GRID_PROCESS_PROFILES
CONFIGURABLE_GRID_BOUNDARIES
CONFIGURABLE_GRID_PATH_POLICIES
        ↓
rectangular_grid_path()
        ↓
printable_alternating_grid_stack()
```

The workbench changes records, not topology. Every deposited layer is one continuous open path. Successive layers alternate X/Y and remain in direct contact.

`paths/rectangular_grid.scad` owns its X-running and Y-running serpentine helpers. The active generator therefore has no dependency on the legacy API v1 rectangular-serpentine file or on global include order.

## Legacy API v1 compatibility route

`grid_stack_render()` and `paths/rectangular_serpentine.scad` remain available only as the frozen API v1 saved-object interface. No active Workbench routes through that pipeline. It is retained to avoid silently breaking external or historical API v1 recipes.

## First-layer route

The First Layer workbench uses the independent variable parallel-trace grammar. It builds a mutable `first_layer_object()` and renders through API version 1 validation and geometry. Accepted historical first-layer recipes remain isolated under versioned APIs.

## Catalog route

The Catalog registry is the destination for accepted immutable recipes. Laboratory and Coupon presets remain mutable and are not catalog products by themselves.

## Preset and manufacturing separation

Customizer JSON stores OpenSCAD-visible parameters. An accepted product is promoted to an immutable `.scad` recipe. Slicer-specific requirements are stored in an associated 3MF manufacturing project and are not simulated by geometry offsets in OpenSCAD.

## Retired coupon implementation

The fixed coupon matrix, positive-gap witness/riser/bridge routes, API version 3 coupon recipes, and coupon-specific tests are not part of the active architecture. They remain available through Git history and the `v0.1.0` release.
