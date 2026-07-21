# Staggered Grid Panel Part Number

The part number is the name assigned to a saved OpenSCAD Customizer preset. It is entered once when the preset is created with the **+** button. OpenSCAD does not need to generate or validate the part number.

## Format

```text
SGP{cellsX}X{cellsY}S{spanX}X{spanY}T{traceWidth}H{layerHeight}L{layers}
```

`SGP` means **Staggered Grid Panel**.

## Encoding rules

| Part-number field | Source | Encoding |
|---|---|---|
| `cellsX` | `lab_cells_x` | X-axis cell count |
| `cellsY` | `lab_cells_y` | Y-axis cell count |
| first `span` | `lab_clear_span_x` | millimetres × 100 |
| second `span` | `lab_clear_span_y` | millimetres × 100 |
| `traceWidth` | active trace/process width | millimetres × 100 |
| `layerHeight` | `lab_deposited_layer_height` | millimetres × 100 |
| `layers` | `lab_deposited_layer_count` | deposited layer count |

Dimensional fields use four digits for normal Grid Stack values. Layer count uses at least two digits.

Examples:

```text
6.00 mm  → 0600
0.40 mm  → 0040
0.20 mm  → 0020
1.00 mm  → 0100
5 layers → 05
```

The current trace width comes from the active process profile. For the current 0.4 mm trace, the field is `T0040`.

## Example

```text
SGP10X10S1000X1000T0040H0100L10
```

This identifies:

```text
10 × 10 cells
10.00 × 10.00 mm clear span
0.40 mm trace width
1.00 mm deposited layer height
10 deposited layers
```

The example part number is 31 characters long.

## Excluded settings

The part number does not include:

- first-layer orientation;
- lead-in length;
- filament type or color;
- printer or slicer settings;
- horizontal expansion;
- load capacity;
- photographs or test results.

These describe manufacturing or a physical artifact, not the immutable panel geometry.

## Naming rule

Any change to cell count, clear span, trace width, deposited layer height, or deposited layer count creates a different part number. Identical geometry keeps the same part number regardless of how many artifacts are printed or tested.
