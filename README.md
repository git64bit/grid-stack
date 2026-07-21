# Grid Stack

Grid Stack is an OpenSCAD project for continuous-nozzle-path structures, calibration sheets, and composite reinforcement grids.

## Current framework

Batch 009 freezes the urgent coupon framework around:

```text
count_boundary()
rectangular 3 × 3 clear-opening grids
square turns
one continuous open path per deposited layer
0.8 × 0.4 mm composed structural strand
one complete X grid layer
one complete Y grid layer
```

The accepted direct-contact reference remains the default project:

```text
COUPON_3X3_SPAN6_GAP0_DIRECT
```

The complete positive-gap matrix is now cataloged:

```text
XY clear spans: 5, 6, 7, 8 mm
Z clear gaps:   1, 2, 3 mm
cases:          12
```

Positive-gap specifications are validated and reported, but printable anchor/support geometry remains an explicit stub. The project will not silently render unsupported floating coupon layers.

## Correct schedule terminology

A schedule count represents one complete continuous **structural path layer**, not one individual parallel strand.

```text
primitive trace                 0.4 × 0.2 mm
composed structural strand      0.8 × 0.4 mm
complete structural path layer  full serpentine using that section
```

New framework code uses `path_layer_group()`. The older `strand_group()` name remains as an API v1 compatibility wrapper.

## First-layer tool

Open:

```text
first-layer-0u2Z-anyXY.scad
```

It produces one primitive layer from independently configured parallel traces:

```scad
traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];
```

Each record is `[axis_min, axis_max, perpendicular_position]`.

## Output modes

```text
structural_coupon   printable direct-contact coupon, or explicit gap stub
path_preview        numbered non-printable centerline diagnostic
report_only         validation and dimensions only
```

## Deferred stubs

The following remain named but inactive:

- dimension-envelope fitting;
- circular and polygon boundaries;
- mixed square/hex patterns;
- expanded 4-5-6-5-4 schedules;
- positive-gap anchor/support geometry.

See `docs/FRAMEWORK_FREEZE.md` and `docs/LESSON_009.md`.

## Versioned recipes

Existing permanent first-layer recipes remain under `objects/printed/` and import explicit APIs. The full coupon set will receive a new isolated versioned API after positive-gap support geometry is accepted.
