
# Grid Stack

Grid Stack is an OpenSCAD project for generating reinforced open-grid prints as one continuous nozzle path per deposited layer.

## Batch 002

Batch 002 corrects the initialization model before geometry begins. It separates:

- material identity;
- nozzle hardware;
- the exact qualified process combining them;
- derived structural-strand dimensions;
- geometry and path policies.

Open `main.scad`, press **F5**, and inspect the console. A successful run reports:

```text
GRID STACK VALIDATION: PASS
Single trace basis: 0.4 x 0.2 mm
Structural pass composition: 2 wide x 2 high
Composed structural strand: 0.8 x 0.4 mm
```

The blank viewport is intentional.

## Governing structural rule

A single nozzle trace and a single deposited layer are process primitives, not accepted structural elements. The reference strand uses at least two passes in both dimensions:

```text
strand width  = nozzle diameter × horizontal passes
strand height = layer height × vertical passes
```

## Repository map

```text
grid-stack/
├── main.scad                  Orchestrates the resolved environment
├── config/materials.scad      Material-family catalog
├── config/nozzles.scad        Nozzle-hardware catalog
├── config/process_profiles.scad  Qualified combinations and observations
├── config/                    Boundaries, schedules, patterns, projects
├── lib/schema.scad            Record constructors
├── lib/indices.scad           Named vector-field indexes
├── lib/process_math.scad      Derived trace and strand dimensions
├── lib/                       Lookup, validation, reporting, utilities
├── paths/                     Future continuous-path generators
├── geometry/                  Future path-to-solid conversion
├── tests/                     Future coupons and path checks
└── docs/                      Specification and tutorial material
```

Read `docs/LESSON_001.md`, then `docs/LESSON_002.md`.
