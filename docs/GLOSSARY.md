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

**Stack schedule** — Ordered sequence of complete structural path-layer groups and clear vertical gaps.

**Coupon series** — Cartesian product of named coupon boundaries and named stack schedules.

**Unsupported span** — Distance crossed without existing material directly below the trace.

**Continuous path** — One open path with no internal lift, travel move, seam, or disconnected island.


## Ordered nozzle path

One list of centerline points traversed from index zero to the final index. Consecutive points define uninterrupted segments; separate point lists would represent separate paths.

## Lead-in

The first segment of the ordered path, beginning outside the coupon envelope and joining the first structural run without a lift or idle travel.

## Square connector

An axis-aligned path segment joining the end of one parallel run to the beginning of the next. It is part of the same ordered path, not a separate border.

## Saved object recipe

A top-level `.scad` file that embeds every geometry-affecting record and calls one versioned Grid Stack public module. It is the authoritative parametric definition of one printed construct.

## API version

Integer identifying a compatible public Grid Stack constructor and execution contract. A recipe asserts the version it requires.

## Object-schema version

Integer identifying the field layout and meaning of the `grid_stack_object()` record.

## Current API alias

`grid_stack.scad`, used for new development. Permanent recipes import an explicit file under `api/` instead.

## Parallel trace
A straight member of one deposited layer that shares an orientation with the other members in its sequence. Its length and perpendicular position are independently configured.

## Repeat distance
The centerline-to-centerline distance between consecutive parallel traces. It is the difference between their perpendicular positions.

## Square connector
The perpendicular segment joining two consecutive parallel traces without a lift or idle move. The connected trace endpoints must share the same coordinate along the trace axis.

## First-layer object
A saved recipe for geometry exactly one nozzle trace wide and one deposited layer high. It is useful for first-layer calibration and sacrificial underlays, but is not a composed structural strand.


**Direct-contact stack**  
Two completed structural paths placed with zero clear vertical gap. The upper
path begins at a crossing supported by the lower path.

**Structural ribbon**  
The OpenSCAD solid swept along a structural path using the composed strand
width and height derived from the process profile.

## Complete structural path layer

One complete continuous serpentine path across a boundary, swept with the composed structural-strand cross-section. This is the unit counted by current stack schedules.

## Path-layer group

A consecutive number of complete structural path layers sharing one orientation and pattern. Constructed with `path_layer_group()`.

## Exploratory span

A clear span intentionally beyond the current owner-tested bridge limit. It is a valid calibration case, not an invalid specification.

## Framework stub

A named extension point that is retained and rejected explicitly until its geometry and validation rules are implemented.
