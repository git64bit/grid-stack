# Immutable Structural Coupons

These recipes are the complete frozen rectangular calibration set for Grid Stack API version 3.

## Geometry

The direct reference uses two orthogonal structural grids in contact.

Every positive-gap coupon uses:

1. a lower Y-running witness grid with the only external lead-in;
2. an X-running riser path repeated through the requested gap;
3. an upper Y-running test grid aligned directly above the witness grid.

The riser walls support each bridge endpoint while leaving the clear openings unobstructed. The aligned witness strand provides a known lower contact target when sag exceeds the selected vertical clearance.

## Matrix

| XY clear span | 1 mm gap | 2 mm gap | 3 mm gap |
|---:|:---:|:---:|:---:|
| 5 mm | included | included | included |
| 6 mm | included | included | included |
| 7 mm | included | included | included |
| 8 mm | included | included | included |

The separate `6 mm / 0 mm` direct-contact recipe records the physically accepted reference.

## Immutability

Each file imports `api/grid_stack_v3.scad`, embeds every geometry-affecting process and boundary value, and calls one public rendering module. Do not edit a recipe after printing. Create a new filename and revision for any material, nozzle, printer, process, span, gap, lead-in, or geometry change.

The `framework_base_commit` field records the accepted repository state from which Batch 010 began. The Git commit containing each recipe remains the authoritative complete source; a source file cannot embed its own future commit hash.
