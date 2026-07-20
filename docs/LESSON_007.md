# Lesson 007 — Promote Prints, Do Not Save Customizer State

## 1. Development and permanent objects are different files

`first-layer-0u2Z-anyXY.scad` is a workbench. Its values may change repeatedly.

A successful print is promoted into a dedicated file under:

```text
objects/printed/
```

That recipe embeds the exact trace records and printing environment used by the object.

## 2. Identical geometry can require separate recipes

The accepted trace sequence is the same for PLA+ and TPU:

```scad
traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];
```

The resulting solids are geometrically identical, but the printed objects are not the same environment. Material is therefore part of the recipe identity and filename.

## 3. Primitive trace and structural process are separate schemas

API version 1 reused `process_profile()` for both structural strands and primitive traces. That record contains:

```text
width passes
height passes
bridge limit
```

Those values do not define a one-trace, one-layer calibration object.

API version 2 introduces `trace_process_profile()` with only:

```text
material
nozzle
printer
layer height
qualification
revision
```

This prevents a primitive trace recipe from carrying irrelevant structural claims.

## 4. API version 1 remains available

Existing version-1 recipes still import:

```scad
include <../api/grid_stack_v1.scad>
```

New printed first-layer recipes import:

```scad
include <../../api/grid_stack_v2.scad>

assert(GRID_STACK_API_VERSION == 2);
assert(GRID_STACK_FIRST_LAYER_SCHEMA_VERSION == 2);
```

A new API file is added instead of changing the meaning of the old public interface.

## 5. Record missing facts explicitly

The printer hardware used for the reported successful PLA+ and TPU prints was not supplied during Batch 007. The recipe therefore stores:

```text
printer status = unrecorded
```

This is an incomplete historical environment, but it is truthful. A future recipe should identify the exact printer and build surface.

## 6. One printed change creates one new recipe

Do not edit a printed recipe. Examples:

```text
...-pla-plus-0p4-v1.scad
...-pla-plus-0p2-v1.scad
...-pla-plus-0p4-v2.scad
```

A new nozzle diameter or revised trace sequence is a different physical experiment even when the object serves the same purpose.
