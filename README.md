# Grid Stack

Grid Stack is an OpenSCAD project for continuous-nozzle-path structures, calibration sheets, and composite reinforcement grids.

## Frozen rectangular framework

Version 1.0 freezes the urgent framework around:

```text
count_boundary()
rectangular clear-opening grids
square turns and square terminations
one continuous open path per deposited layer
explicit material, nozzle, printer, and process records
immutable saved-object recipes
```

The active calibration set contains thirteen objects:

```text
1 direct-contact reference: 6 mm span / 0 mm gap
12 positive-gap coupons:    spans 5, 6, 7, 8 mm × gaps 1, 2, 3 mm
```

## Positive-gap construction

A positive-gap coupon is not floating geometry. It uses three continuous paths:

```text
upper Y test grid
        ↑ supported by X riser walls
X riser path repeated through the requested gap
        ↑ begins on the witness crossings
lower Y witness grid with the only external lead-in
```

The witness and upper test grids are vertically aligned. If a bridge sags by the selected clearance, it reaches the known witness strand below. Every riser layer repeats the same continuous open X path.

## Workbench

Open `main.scad` and select any coupon project in the Customizer. The default is:

```text
COUPON_3X3_SPAN6_GAP1
```

Output modes:

```text
structural_coupon   printable coupon geometry
path_preview        numbered non-printable centerline diagnostic
report_only         validation and dimensions only
```

## Permanent recipes

The full set is under:

```text
objects/coupons/
```

Every recipe imports `api/grid_stack_v3.scad`, embeds all geometry-affecting values, asserts API/schema/framework versions, and calls one public rendering module.

## First-layer tool

`first-layer-0u2Z-anyXY.scad` remains the independent primitive-trace tool for first-layer calibration and anti-warp underlays.

## Deferred stubs

The following remain named but inactive:

- dimension-envelope fitting;
- circular boundaries;
- regular and custom polygon boundaries;
- mixed square/hex pattern zones;
- expanded schedules beyond the frozen coupon strategies.

See `docs/FRAMEWORK_FREEZE.md` and `docs/LESSON_010.md`.
