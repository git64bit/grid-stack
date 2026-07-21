# Lesson 010 — Geometry Support Is Part of the Object

A requested vertical gap is not printable merely because two solids can be placed at different Z coordinates. The upper solid must be reached through deposited material.

## The failed abstraction

```text
lower grid
empty Z distance
upper grid
```

This describes the desired measurement but leaves the upper grid floating. A slicer must either create support, travel to unsupported material, or fail.

## The frozen construction

```text
upper test path, Y-running
orthogonal riser walls, X-running
lower witness path, Y-running
```

The witness path has the only external lead-in. The first riser layer starts at a witness crossing and bridges to the next witness crossing. Each later riser layer repeats the same open path. The upper test path starts on the completed riser and bridges between riser walls.

## Why the witness is aligned

The upper test path and lower witness path use the same XY centerline. The requested gap is therefore a measurable clearance between known strands. Sag greater than that clearance can contact the witness below instead of disappearing into an undefined empty volume.

## Layer quantization

A clear vertical gap must be a whole number of deposited layers:

```text
gap layers = clear vertical gap / deposited layer height
```

For the current process:

```text
1 mm / 0.2 mm = 5 layers
2 mm / 0.2 mm = 10 layers
3 mm / 0.2 mm = 15 layers
```

API version 3 rejects a recipe when this quotient is not an integer.

## Saved recipes

A permanent object embeds:

- material;
- nozzle;
- printer identity or an explicit unrecorded value;
- deposited layer height;
- horizontal and vertical pass counts;
- bridge qualification;
- count boundary;
- clear vertical gap;
- lead-in;
- support strategy;
- API, schema, and framework versions.

The Customizer remains a workbench. The `.scad` recipe is the saved object.
