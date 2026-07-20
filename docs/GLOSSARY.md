# Glossary

**Material specification** — Identity record for a filament family; not a complete printing setup.

**Nozzle specification** — Hardware record defining the nominal width basis of one pass.

**Process profile** — Exact qualified combination of material, nozzle, layer height, pass composition, and tested behavior.

**Trace** — Material deposited by one nozzle pass in one layer. It is not accepted as a structural element by itself.

**Structural strand** — Composed feature using at least two horizontal traces and at least two deposited layers.

**Strand width** — Nozzle diameter multiplied by horizontal pass count.

**Strand height** — Layer height multiplied by vertical pass count.

**Clear span** — Unsupported edge-to-edge opening between neighboring structural strands.

**Strand pitch** — Centerline distance between neighboring structural strands: clear span plus strand width.

**Dimension-driven boundary** — Boundary whose required outside dimensions are authoritative.

**Count-driven boundary** — Boundary whose clear-opening count and clear span are authoritative.

**Grid cell count** — Number of clear openings. A count of `n` requires `n + 1` bounding structural strands.

**Clear vertical gap** — Empty Z distance between completed structural-strand groups.

**Stack schedule** — Ordered sequence of completed structural-strand groups and clear vertical gaps.

**Coupon series** — Cartesian product of named coupon boundaries and named stack schedules.

**Unsupported span** — Distance crossed without existing material directly below the trace.

**Continuous path** — One open path with no internal lift, travel move, seam, or disconnected island.


## Ordered nozzle path

One list of centerline points traversed from index zero to the final index. Consecutive points define uninterrupted segments; separate point lists would represent separate paths.

## Lead-in

The first segment of the ordered path, beginning outside the coupon envelope and joining the first structural run without a lift or idle travel.

## Square connector

An axis-aligned path segment joining the end of one parallel run to the beginning of the next. It is part of the same ordered path, not a separate border.
