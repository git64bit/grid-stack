# Lesson 001 — Orchestration Before Geometry

The purpose of this batch is to learn how values move through a disciplined OpenSCAD project.

## Follow one value

Trace `bridge_max` through these files:

1. `config/materials.scad` assigns `6.0`.
2. `lib/schema.scad` places it in the material record.
3. `lib/indices.scad` names its position `M_BRIDGE_MAX`.
4. `lib/validation.scad` confirms it is positive.
5. `lib/reporting.scad` prints it to the console.
6. `main.scad` orchestrates those steps without knowing the numeric index.

That is the core architectural pattern:

```text
configuration → schema → lookup → validation → use
```

## Why no geometry yet

Geometry written before vocabulary and constraints tends to hard-code assumptions. This batch establishes names for the concepts the future path generator must obey.

## Safe exercises

Change only one item at a time and press F5:

- Set `bridge_max` to `-1` and observe the assertion.
- Change one outer layer count from `4` to `3` and observe the symmetry assertion.
- Change a zone pitch to `0.8` and observe the no-open-gap assertion.
- Restore each value after the test.

## Do not add path code yet

Batch 002 will introduce the first path object: a rectangular, fixed-spacing, square-turn serpentine with one lead-in and no disconnected geometry.
