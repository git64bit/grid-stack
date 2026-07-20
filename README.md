# Grid Stack

Grid Stack is an OpenSCAD project for generating reinforced, open-grid prints as one continuous nozzle path per deposited layer.

The governing priorities are:

1. one uninterrupted nozzle path;
2. explicit minimum and maximum geometric limits;
3. programmable layer schedules;
4. programmable pattern zones;
5. boundary-aware paths rather than clipped disconnected geometry.

## Batch 001

Batch 001 defines the project vocabulary, folder structure, configuration records, validation rules, and reporting. It intentionally generates no geometry.

Open `main.scad`, press **F5**, and inspect the OpenSCAD Console. A successful run reports:

```text
GRID STACK VALIDATION: PASS
```

The blank viewport is expected in this batch.

## Current reference specification

- 0.4 mm nozzle
- 0.4 mm nominal line width
- 0.2 mm layer height
- 0.8 mm bridge strand width
- 6 mm maximum unsupported span
- two deposited layers to complete the bridge strand
- one continuous path with a 30 mm lead-in
- symmetric `X4, Y5, X6, Y5, X4` schedule
- two outer square rows with a hexagonal interior

The 0.8 mm minimum clear gap and 4 mm pattern pitch are provisional tutorial values. They must be validated by physical coupons before becoming accepted process limits.

## Repository map

```text
grid-stack/
├── main.scad              Orchestrates selection, lookup, validation, reporting
├── config/                Human-editable project records and presets
├── lib/                   Generic schema, lookup, math, validation, reporting
├── paths/                 Future continuous-path generators
├── geometry/              Future conversion of paths into printable solids
├── tests/                 Future validation coupons and path checks
├── docs/                  Specification and tutorial material
├── exports/               Generated meshes; not committed
└── renders/               Generated images; not committed
```

Read `docs/LESSON_001.md` before changing the configuration.
