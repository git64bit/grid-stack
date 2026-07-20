# Architecture

## Entry point

`main.scad` performs orchestration only:

1. load constructor and math libraries;
2. load configuration catalogs;
3. resolve named records;
4. validate the selected environment and project;
5. print the project and coupon-series reports.

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

## Future generation layers

`paths/` will construct ordered continuous centerlines.

`geometry/` will convert validated paths into printable structural strands.

`tests/` will expose coupons and diagnostic views.

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
