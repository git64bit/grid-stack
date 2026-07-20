# Architecture

The project separates six concerns.

## 1. Configuration

`config/` contains named records. These answer: **what should be generated?**

Examples:

- material and nozzle limits;
- boundary selection;
- layer schedule;
- pattern zones;
- path policy.

## 2. Schema

`lib/schema.scad` contains record constructors. These answer: **what fields must each configuration record contain?**

OpenSCAD arrays are positional. Constructors and named indexes prevent unexplained numeric indexes from spreading through the project.

## 3. Lookup

`lib/lookup.scad` resolves a human-readable name to exactly one record. Duplicate or missing names stop the model immediately.

## 4. Validation

`lib/validation.scad` rejects contradictory or impossible configurations before geometry is attempted.

## 5. Path generation

`paths/` will eventually create ordered centerline points. It must not create printable solids directly.

## 6. Geometry generation

`geometry/` will convert an accepted ordered path into strand geometry with nozzle-width and layer-height dimensions.

This separation permits the same path to be previewed, measured, validated, or extruded without rewriting the pattern logic.
