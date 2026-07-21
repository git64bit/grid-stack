# Rectangular Framework Freeze

## Frozen version

```text
GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION = 2
GRID_STACK_API_VERSION = 3
GRID_STACK_COUPON_SCHEMA_VERSION = 1
```

## Supported boundary

```scad
count_boundary(
    name,
    cells_x,
    cells_y,
    clear_span_x,
    clear_span_y
);
```

Cell counts refer to clear openings. A 3 × 3 boundary contains four structural strands in each direction. Outside dimensions are derived; no perimeter border is added.

## Supported geometry strategies

### `direct_orthogonal`

Used only for the 0 mm reference:

```text
lower X structural grid
upper Y structural grid in direct contact
```

### `witness_riser_bridge`

Used for positive gaps:

```text
lower Y witness grid
X riser path repeated through the gap
upper Y test grid aligned over the witness
```

The gap must equal a whole number of deposited layers.

## Frozen process semantics

```text
primitive trace:       nozzle diameter × deposited layer height
structural strand:     two or more traces wide × two or more layers high
riser wall:            structural width × requested layer-quantized gap
```

For the current qualified process:

```text
trace:                  0.4 × 0.2 mm
structural strand:      0.8 × 0.4 mm
gap layers:             5, 10, or 15
```

## Saved-object rule

Every permanent coupon imports `api/grid_stack_v3.scad`, embeds all exact records, and asserts the API, schema, and framework versions. Existing recipe files and API version 3 are immutable by convention.

## Deferred names

The following remain visible but unsupported:

- `dimension_boundary`;
- `circle_boundary`;
- `regular_polygon_boundary`;
- `custom_polygon_boundary`;
- `mixed_square_hex_pattern`;
- expanded layer schedules.

Selecting a deferred workbench project must fail explicitly rather than approximate.
