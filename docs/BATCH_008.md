# Batch 008 — First structural stack coupon

Base commit: `79a52cf`

## Purpose

Convert the qualified process definition into the first printable composed
structural-strand stack.

The current process derives:

```text
primitive trace       0.4 mm wide × 0.2 mm high
width composition     2 traces
height composition    2 deposited layers
structural strand     0.8 mm wide × 0.4 mm high
```

## Geometry

The selected project is:

```text
COUPON_3X3_SPAN6_GAP0_DIRECT
```

It contains:

1. one X-running composed structural path;
2. one Y-running composed structural path directly above it;
3. a 30 mm lead-in on the lower path only;
4. an upper path that starts at the lower-left crossing on deposited material;
5. no positive vertical gap.

The modeled outside grid dimensions are 21.2 × 21.2 mm, excluding the lower
lead-in. The total stack height is 0.8 mm.

## Deliberate limit

Positive vertical gaps remain disabled. A 1–3 mm gap requires a defined anchor
or support strategy; otherwise the upper path would begin in unsupported air.
The twelve span/gap recipes remain deferred until that behavior is designed and
printed successfully.

## Acceptance test

Open `main.scad`. The defaults select `structural_coupon` and the Batch 008
project. Press F5, then F6 and inspect the slicer.

Expected console messages include:

```text
GRID STACK VALIDATION: PASS
GRID STACK STRUCTURAL COUPON VALIDATION: PASS
Structural strand: 0.8 x 0.4 mm
Total modeled stack height: 0.8 mm
```

The slicer must show the intended two traces per deposited layer and one
uninterrupted route per deposited layer before the coupon is qualified.
