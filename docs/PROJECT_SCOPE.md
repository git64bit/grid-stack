
# Project Scope

Grid Stack generates printable open-grid structures from explicit continuous-nozzle-path rules.

## Primary invariant

Every deposited layer must be exactly one open continuous path with no internal lift, travel move, disconnected island, or independent closed loop.

## Structural primitive

One trace and one deposited layer are not accepted structural units. The minimum structural unit is a composed strand with at least two horizontal passes and two vertical deposited layers.

## Environment rule

Material, nozzle diameter, layer height, pass composition, and observed bridge behavior form one qualified process environment. Changing any member requires a new named process profile and requalification.

## Batch 002 boundary

Batch 002 defines and validates the environment model. It does not generate paths or geometry.
