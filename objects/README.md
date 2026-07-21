# Saved Objects

Every accepted Grid Stack product receives a dedicated immutable `.scad` recipe.

A saved recipe must:

- import an explicit versioned API under `api/`;
- assert its required API and object schema;
- embed exact geometry-affecting environment and object records;
- avoid Customizer state and mutable registry lookup;
- call exactly one public rendering module;
- receive a new filename and revision after any printed version changes.

## Current retained objects

- `printed/` — immutable PLA+ and TPU first-layer objects using API version 2.
- `first-layer-0u2Z-variable-50x18-v1.scad` — historical API version 1 first-layer recipe retained unchanged.

The former coupon recipe set was retired after coupons moved to the generic Customizer workbench. New accepted grid objects will be added through Catalog promotion rather than restored as a hard-coded matrix.

## Manufacturing project

Geometry recipes do not encode slicer-only compensation. An accepted object may be paired with a slicer 3MF project containing settings such as horizontal expansion, printer selection, material profile, support behavior, and other manufacturing requirements.
