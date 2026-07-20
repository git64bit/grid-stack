# Grid Stack

Grid Stack is an OpenSCAD project for generating reinforced open-grid prints as one continuous nozzle path per deposited layer.

## Batch 005

Batch 005 establishes permanent saved-object recipes before printable strand geometry is added.

- `main.scad` remains the Customizer-driven development workbench.
- `grid_stack.scad` loads the current public API.
- `api/grid_stack_v1.scad` is the explicit API version used by permanent recipes.
- `objects/*.scad` stores complete, self-contained object definitions.
- API and object-schema assertions prevent silent incompatible execution.
- Exact historical implementation remains available through the Git commit or tag containing the recipe.

Open either:

```text
main.scad
```

for catalog-driven development, or:

```text
objects/coupon_3x3_span6_gap2_v1.scad
```

for the first permanent recipe example. Both currently render diagnostic centerlines rather than printable solids.

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
├── main.scad                         Development orchestrator
├── grid_stack.scad                   Current public API alias
├── api/grid_stack_v1.scad            Versioned public interface
├── objects/                           Permanent self-contained recipes
├── config/                            Mutable development catalogs
├── lib/schema.scad                   Record constructors
├── lib/indices.scad                  Named vector-field indexes
├── lib/object_validation.scad        Saved-object assertions
├── lib/object_reporting.scad         Saved-object report
├── paths/rectangular_serpentine.scad Continuous centerline generator
├── geometry/path_preview.scad        Non-printable diagnostic display
└── docs/                              Specification and tutorial lessons
```

Read `docs/LESSON_001.md` through `docs/LESSON_005.md` in order.
