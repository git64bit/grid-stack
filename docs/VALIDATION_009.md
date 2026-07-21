# Validation 009

## Static contract targets

`tests/framework_freeze_contract.scad` verifies:

- four active count boundaries;
- twelve positive-gap projects;
- one accepted direct-contact reference;
- four structural runs for each side of a 3 × 3 opening count;
- derived outside dimensions;
- two complete path layers per coupon;
- four raw deposited layers for the current 2-high process;
- total height equals material height plus clear Z gap;
- only the zero-gap schedule is currently printable.

`tests/structural_coupon_contract.scad` retains the accepted 6 mm direct-contact dimensional and path assertions using the corrected path-layer terminology.

## Manual OpenSCAD checks

1. Open `main.scad` with the default direct-contact project.
2. Press F5 and confirm both framework and coupon specification PASS messages.
3. Press F6 and confirm the accepted direct-contact coupon still renders.
4. Select a positive-gap project and use `report_only`.
5. Confirm dimensions and the `stub_requires_anchor_support` status are reported.
6. Select `structural_coupon` for the same positive-gap project.
7. Confirm the explicit vertical-gap geometry stub assertion stops rendering.
8. Select `TUTORIAL_RECT_45654` and confirm the deferred boundary/pattern assertion stops execution before path generation.

## Expected default dimensions

For 3 × 3 clear openings, 6 mm clear span, and a 0.8 mm strand:

```text
outside X = 3(6) + 4(0.8) = 21.2 mm
outside Y = 21.2 mm
material height = 2(0.4) = 0.8 mm
clear Z gap = 0 mm
total height = 0.8 mm
```
