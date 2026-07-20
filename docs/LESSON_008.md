# Lesson 008 — Compose traces into a structural stack

## 1. Geometry follows the process record

Batch 008 does not store `0.8` and `0.4` as independent design dimensions.
They remain derived:

```scad
strand_width(process, nozzle)
strand_height(process)
```

For the current qualified process:

```text
0.4 mm nozzle × 2 width passes  = 0.8 mm
0.2 mm layer  × 2 height passes = 0.4 mm
```

Changing the nozzle or process profile therefore changes the structural strand
rationally rather than leaving hidden dimensions behind.

## 2. Paths and solids remain separate

`paths/structural_coupon_paths.scad` creates ordered point lists only.

`geometry/structural_strand.scad` converts those paths into composed printable
ribbons.

`geometry/orthogonal_stack_coupon.scad` places the ribbons in Z.

This separation lets path rules change without rewriting extrusion geometry,
and lets geometry change without rewriting boundary mathematics.

## 3. The upper layer has no external lead-in

The lower path begins outside the coupon and enters continuously. The upper
path starts at the shared lower-left crossing. This avoids placing an upper
lead-in in unsupported air.

The upper layer still has one unavoidable layer start. It is placed at a
structural crossing rather than along an exposed span.

## 4. OpenSCAD geometry is not G-code

The model defines the intended structural ribbon and ordered centerline. The
slicer still decides the exact extrusion order inside a 0.8 mm ribbon.

Therefore qualification has two stages:

1. OpenSCAD validation: dimensions, topology, and layer placement;
2. slicer validation: two passes, one uninterrupted route, and correct starts.

A successful physical print can then be promoted into an immutable saved-object
recipe under a new versioned API.

## 5. Why the vertical gap remains zero

Direct contact is the smallest complete experiment. It validates:

- trace-to-strand composition;
- X/Y alternation;
- bridge span at 6 mm;
- layer starts and square turns;
- total stack height.

A positive Z gap adds a separate problem: how the upper path is anchored before
it bridges. That belongs in the next design discussion rather than being hidden
inside this coupon.
