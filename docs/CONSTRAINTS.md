# Constraints

## Continuous nozzle path

Each deposited layer must be represented by one open, uninterrupted path with no internal travel move, lift, closed subpath, or disconnected island.

## Structural minimum

A trace is not considered reliable by itself. Every structural strand must use at least:

- two horizontal nozzle passes;
- two deposited layers in height.

## Bridge qualification

The active PLA+ process records 6 mm as the current qualified maximum unsupported clear span. Coupon cases beyond 6 mm are permitted only as explicit exploratory tests.

## Boundary authority

A boundary must be either:

- dimension-driven, with outside dimensions as inputs; or
- count-driven, with clear-opening count and clear span as inputs.

The two modes must not silently override one another.

## Grid count

Grid count means clear openings. `n` openings require `n + 1` structural strands along the same axis.

## Vertical separation

Clear vertical gap is separate from material height. It is measured between the top of one completed structural path-layer group and the bottom of the next.

## Schedule units

Schedule counts refer to complete continuous structural path layers, not individual parallel strands. Deposited-layer counts are derived from the active process profile.

## First-layer parallel traces

- Every trace record has exactly three numeric fields.
- `axis_max` must be greater than `axis_min`.
- Perpendicular positions must be strictly monotonic.
- Repeat distance must be at least the nozzle trace width.
- Consecutive traces must share the alternating endpoint used by their connector.
- The generated route must be one open, axis-aligned path with no zero-length segment.
- Printable trace geometry uses square ends and square perpendicular turns.
