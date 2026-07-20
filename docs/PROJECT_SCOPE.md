# Project Scope

Grid Stack generates printable open-grid structures from explicit continuous-nozzle-path rules.

## Primary invariant

Every deposited layer must be exactly one open continuous path with no internal lift, travel move, disconnected island, or independent closed loop.

## Structural primitive

One trace and one deposited layer are not accepted structural units. The minimum structural unit is a composed strand with at least two horizontal passes and two vertical deposited layers.

## Environment rule

Material, nozzle diameter, layer height, pass composition, and observed bridge behavior form one qualified process environment. Changing any member requires a new named process profile and requalification.

## Boundary rule

A boundary has one authoritative mode:

- outside dimensions for a finished part; or
- clear-opening count and clear span for a controlled coupon.

Derived dimensions must not be copied back into configuration as competing inputs.

## Schedule rule

Schedules count completed structural strands. Raw deposited layers and resulting stack height are derived from the selected process profile.

## Batch 003 boundary

Batch 003 defines and validates boundary modes, vertical clear gaps, and coupon matrices. It does not generate paths or geometry.
