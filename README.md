# Grid Stack

Grid Stack is an OpenSCAD project for generating reinforced open-grid prints as one continuous nozzle path per deposited layer.

## Batch 003

Batch 003 adds two independent boundary modes and an explicit coupon matrix while still generating no geometry.

- **Dimension-driven boundaries** begin with required outside dimensions.
- **Count-driven boundaries** begin with clear-opening count and clear span.
- Stack schedules count completed structural strands, not raw deposited layers.
- Clear vertical separation is recorded independently from material height.
- A 3 × 3 coupon series varies clear span from 5–8 mm and vertical gap from 1–3 mm.

Open `main.scad`, press **F5**, and inspect the console. A successful run reports:

```text
GRID STACK VALIDATION: PASS
GRID STACK COUPON SERIES VALIDATION: PASS
```

The viewport remains blank by design.

## Governing process model

A single nozzle trace and a single deposited layer are process primitives, not accepted structural elements.

```text
trace width   = nozzle diameter
trace height  = deposited layer height
strand width  = trace width × horizontal passes
strand height = trace height × vertical passes
```

The reference process produces a `0.8 × 0.4 mm` structural strand from a `0.4 mm` nozzle, `0.2 mm` layer height, and two passes in both directions.

## Boundary equations

A count-driven boundary counts clear openings. Three openings require four structural strands:

```text
outside size = cells × clear span
             + (cells + 1) × strand width
             + 2 × edge margin
```

For a 3 × 3 coupon with 5 mm clear spans and 0.8 mm strands, the outside size is 18.2 × 18.2 mm.

## Repository map

```text
grid-stack/
├── main.scad                     Orchestrates selection and reporting
├── config/materials.scad         Material-family catalog
├── config/nozzles.scad           Nozzle-hardware catalog
├── config/process_profiles.scad  Qualified process environments
├── config/boundaries.scad        Dimension and count boundary records
├── config/schedules.scad         Structural-strand stack schedules
├── config/coupons.scad           Experimental coupon matrices
├── config/                       Paths, patterns, projects, selectors
├── lib/schema.scad               Record constructors
├── lib/indices.scad              Named vector-field indexes
├── lib/*_math.scad               Derived process and geometry values
├── lib/validation.scad           Specification assertions
├── lib/*reporting.scad           Console inspection
├── paths/                        Future continuous-path generators
├── geometry/                     Future path-to-solid conversion
├── tests/                        Future rendered coupons and checks
└── docs/                         Specification and tutorial material
```

Read `docs/LESSON_001.md`, `docs/LESSON_002.md`, then `docs/LESSON_003.md`.
