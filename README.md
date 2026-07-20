# Grid Stack

Grid Stack is an OpenSCAD project for generating reinforced open-grid prints as one continuous nozzle path per deposited layer.

## Batch 004

Batch 004 generates the first ordered coupon centerline.

- The default project is a 3 × 3 count-driven coupon with 5 mm clear spans.
- One 30 mm lead-in begins outside the coupon.
- Four parallel runs and three square connectors form one open path.
- No perimeter border, nozzle lift, travel segment, or closed subpath is added.
- The viewport is a diagnostic centerline preview, not a printable strand.

Open `main.scad` and press **F5**. A successful run reports:

```text
GRID STACK VALIDATION: PASS
GRID STACK COUPON SERIES VALIDATION: PASS
GRID STACK GENERATED PATH VALIDATION: PASS
```

The green marker is the single path start. The red marker is the single path end. Numbered points show the exact traversal order.

## Governing process model

A single nozzle trace and a single deposited layer are process primitives, not accepted structural elements.

```text
trace width   = nozzle diameter
trace height  = deposited layer height
strand width  = trace width × horizontal passes
strand height = trace height × vertical passes
```

The reference process produces a `0.8 × 0.4 mm` structural strand from a `0.4 mm` nozzle, `0.2 mm` layer height, and two passes in both directions.

## Repository map

```text
grid-stack/
├── main.scad                         Orchestrates selection and delegation
├── config/                           Environment and project records
├── lib/schema.scad                   Record constructors
├── lib/indices.scad                  Named vector-field indexes
├── lib/path_math.scad                Ordered-path measurements
├── lib/path_validation.scad          Path assertions
├── lib/path_reporting.scad           Path console report
├── paths/rectangular_serpentine.scad First continuous-path generator
├── geometry/path_preview.scad        Non-printable diagnostic display
├── tests/                             Future printable calibration outputs
└── docs/                              Specification and tutorial lessons
```

Read `docs/LESSON_001.md` through `docs/LESSON_004.md` in order.
