# Batch 003 — Boundary Modes and Coupon Matrices

## Source of truth

Built from accepted commit `c923e5e`.

## Implemented

- Added `dimension_boundary()` and `count_boundary()` constructors.
- Defined grid count as the number of clear openings.
- Derived count-driven outside dimensions from clear span and strand width.
- Added fixed-pitch and boundary-clear-span pattern spacing policies.
- Replaced raw-layer schedules with completed structural-strand schedules.
- Added explicit clear vertical gaps between strand groups.
- Added four 3 × 3 coupon boundaries at 5, 6, 7, and 8 mm clear span.
- Added three coupon schedules at 1, 2, and 3 mm vertical clear gap.
- Added a 12-case coupon series report.
- Added standard headers to all new OpenSCAD source files.

## Test

Open `main.scad` and press F5.

Expected messages include:

```text
GRID STACK VALIDATION: PASS
Scheduled structural strands: 24
Required deposited layers: 48
Material height: 9.6 mm
GRID STACK COUPON SERIES VALIDATION: PASS
Cases: 12
```

The 3 × 3, 5 mm coupon case should report:

```text
outside size: 18.2 × 18.2 mm
```

The viewport remains blank. Geometry begins only after this specification is accepted.
