# Glossary

**Material specification** — Identity record for a filament family; not a complete printing setup.

**Nozzle specification** — Hardware record defining the nominal width basis of one pass.

**Printer specification** — Identity record for machine and build-surface hardware. An unknown machine is recorded explicitly as unrecorded.

**Process profile** — Exact combination of material, nozzle, printer, layer height, pass composition, bridge observation, qualification, and revision.

**Trace** — Material deposited by one nozzle pass in one layer. It is not accepted as a structural element by itself.

**Structural strand** — Composed feature using at least two horizontal traces and at least two deposited layers.

**Strand width** — Nozzle diameter multiplied by horizontal pass count.

**Strand height** — Layer height multiplied by vertical pass count.

**Clear span** — Unsupported edge-to-edge opening between neighboring structural supports.

**Strand pitch** — Centerline distance between neighboring strands: clear span plus strand width.

**Count-driven boundary** — Boundary whose clear-opening count and clear span are authoritative.

**Dimension-driven boundary** — Deferred boundary whose requested outside envelope is authoritative.

**Grid cell count** — Number of clear openings. A count of `n` requires `n + 1` bounding strands.

**Clear vertical gap** — Empty Z distance between the top of the lower witness and bottom of the upper test strand, except where the required riser walls cross the opening.

**Continuous path** — One open ordered centerline with no internal lift, travel move, seam, or disconnected island.

**Lead-in** — Initial segment beginning outside the coupon and joining the first grid run without a lift or idle travel.

**Square connector** — Perpendicular segment joining consecutive parallel runs as part of the same ordered path.

**Direct-contact stack** — Accepted 0 mm reference with a lower X grid and upper Y grid in direct Z contact.

**Witness grid** — Lower Y-running structural grid aligned directly below the upper test grid. It provides a known lower contact target for sag measurements.

**Riser path** — X-running continuous path repeated through every raw layer of a positive vertical gap.

**Riser wall** — Printed result of repeating the riser path through the selected gap height. It supports upper bridge endpoints while leaving the clear spans open.

**Upper test grid** — Y-running structural grid aligned above the witness and supported by the riser-wall tops.

**Witness/riser/bridge strategy** — Frozen positive-gap construction consisting of a witness grid, orthogonal riser walls, and aligned upper test grid.

**Gap-layer count** — Clear vertical gap divided by deposited layer height. It must be an integer.

**Complete structural path layer** — One complete continuous serpentine swept with the composed structural-strand cross-section.

**Exploratory span** — Clear span intentionally beyond the current owner-tested bridge limit. It is a valid calibration case, not an invalid specification.

**Saved object recipe** — Top-level `.scad` file embedding every geometry-affecting record and calling one versioned public module.

**API version** — Integer identifying a compatible public constructor and rendering contract.

**Coupon-schema version** — Integer identifying the field layout and meaning of an immutable structural-coupon record.

**Framework version** — Integer identifying the frozen supported geometry and validation rules.

**Framework base commit** — Accepted repository commit used as the starting point for a new implementation batch. The later commit containing the recipe remains the authoritative complete source.

**Framework stub** — Named extension point rejected explicitly until its geometry and validation rules are implemented.
