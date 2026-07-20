# Architecture

## Entry point

`main.scad` performs orchestration only:

1. load constructor and math libraries;
2. load configuration catalogs;
3. resolve named records;
4. validate the selected environment and project;
5. print the project and coupon-series reports;
6. delegate count-driven coupon path generation when selected;
7. validate and display the diagnostic centerline.

## Configuration layer

`config/` contains declarative records:

- material identities;
- nozzle hardware;
- qualified process environments;
- dimension and count boundaries;
- path policies;
- pattern topology and spacing source;
- structural-strand stack schedules;
- coupon matrices;
- project references.

Configuration files do not generate geometry.

## Library layer

`lib/` contains:

- record constructors and field indexes;
- named lookup;
- process, boundary, pattern, and stack mathematics;
- validation;
- reporting.

Pure math files do not depend on project selections.

## Generation layers

`paths/` constructs ordered continuous centerlines. The first implementation is the rectangular coupon serpentine.

`geometry/` displays or converts validated paths. Batch 004 contains only diagnostic path preview geometry; printable structural-strand conversion remains next.

`tests/` will expose printable coupons after stack generation.

## Dependency direction

```text
main.scad
   ↓
configuration records
   ↓
constructors, indexes, lookup, pure math
   ↓
future path generation
   ↓
future solid generation
```

Dependencies should not point upward. A generic math library must not select a project or read Customizer variables.
