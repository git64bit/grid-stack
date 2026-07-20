# Data Model

## Material profile

Records nozzle and extrusion dimensions, bridge behavior, and allowed clear-gap range.

The material profile represents a tested process, not merely a filament brand.

## Boundary

Defines the intended outer contour independently from the pattern. Batch 001 includes rectangle, circle, and regular hexagon records, although only the rectangle is selected.

## Path policy

Defines continuity requirements, lead-in and lead-out behavior, and whether travel, lift, or closed subpaths are permitted.

## Pattern set

Contains one or more zones. The reference set contains:

- an outer band two rows deep using a square pattern;
- a remaining interior using a hexagonal pattern;
- a required continuous transition between them.

## Layer schedule

A schedule is an ordered list of groups. Each group states:

- orientation in degrees;
- number of deposited layers;
- pattern-set name;
- Z-step multiplier.

The reference schedule is a palindrome:

```text
X × 4 → Y × 5 → X × 6 → Y × 5 → X × 4
```

## Project specification

A project specification contains only references to named records. It does not duplicate their dimensions.
