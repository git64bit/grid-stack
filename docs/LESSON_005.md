# Lesson 005 — Saving an Object as Source

## 1. OpenSCAD saves instructions, not project state

A FreeCAD-style project stores modeled state. OpenSCAD reconstructs an object by evaluating source. Therefore the permanent Grid Stack object is a top-level `.scad` recipe.

`main.scad` remains the development workbench. It uses Customizer selections and mutable catalogs. A file in `objects/` is the permanent record of one configured construct.

## 2. Import an explicit API version

A saved recipe begins with:

```scad
include <../api/grid_stack_v1.scad>

assert(GRID_STACK_API_VERSION == 1,
    "This recipe requires Grid Stack API version 1.");
```

The include selects the versioned public interface. The assertion stops execution if the loaded interface is incompatible.

The assertion is not a source-code archive. Exact historical implementation is recovered from the Git commit or tag containing the recipe.

## 3. Embed records instead of catalog names

Development code may select:

```scad
process = named_record(PROCESS_PROFILES, selected_name, "process profile");
```

A permanent recipe instead constructs the exact record:

```scad
saved_process = process_profile(
    name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    material_name = "PLA_PLUS",
    nozzle_name = "BRASS_0P4",
    layer_height = 0.2,
    width_passes = 2,
    height_passes = 2,
    bridge_max = 6,
    qualification = "owner_tested",
    revision = 1
);
```

This prevents a later catalog edit from silently changing an old object.

## 4. Compose one saved-object record

`grid_stack_object()` groups the embedded records and object metadata into one record-like vector:

```scad
saved_object = grid_stack_object(
    name = "COUPON_3X3_SPAN6_GAP2_V1",
    revision = 1,
    required_api_version = 1,
    object_schema_version = 1,
    source_release = "0.5.0",
    material = saved_material,
    nozzle = saved_nozzle,
    process = saved_process,
    boundary = saved_boundary,
    path_policy_record = saved_path_policy,
    pattern_set_record = saved_pattern_set,
    schedule = saved_schedule,
    path_orientation = 0,
    status = "calibration"
);
```

The constructor provides readable named arguments. Internally, the result remains an ordered vector. Named indexes in `lib/indices.scad` are the access contract.

## 5. Call one public module

The recipe ends with one execution call:

```scad
grid_stack_render(saved_object, mode = "path_preview");
```

The public module performs four steps:

1. validate API and object-schema compatibility;
2. validate every embedded engineering record;
3. report the complete environment and object identity;
4. delegate to the requested supported output mode.

Future printable modes can be added behind this public module without turning the saved recipe into an orchestrator.

## 6. Revision rule

After an object has been printed, do not edit its recipe. Create a new revision:

```text
coupon_3x3_span6_gap2_v1.scad
coupon_3x3_span6_gap2_v2.scad
```

Git preserves the matching implementation. The filename and internal object revision make the relationship visible outside Git.

## Exercise

Open `objects/coupon_3x3_span6_gap2_v1.scad` directly and press F5. Compare it with `main.scad`:

- `main.scad` selects mutable catalog entries;
- the saved recipe embeds its records;
- both delegate to shared library code;
- only the saved recipe asserts an explicit API requirement.
