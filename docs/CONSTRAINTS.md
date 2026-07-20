
# Constraints Register

## Hard structural invariants

| Constraint | Rule |
|---|---:|
| Horizontal passes per structural strand | at least 2 |
| Vertical deposited layers per structural strand | at least 2 |
| Paths per deposited layer | exactly 1 |
| Internal travel moves | 0 |
| Internal nozzle lifts | 0 |
| Closed independent subpaths | 0 |

## Qualified reference environment

| Property | Value |
|---|---:|
| Material | PLA+ |
| Nozzle diameter | 0.4 mm |
| Layer height | 0.2 mm |
| Horizontal passes | 2 |
| Vertical passes | 2 |
| Composed strand width | 0.8 mm |
| Composed strand height | 0.4 mm |
| Maximum unsupported span | 6.0 mm |

## Removed provisional constraints

Batch 002 removes `min_clear_gap` and `max_clear_gap`. Clear opening, grout-flow opening, and unsupported span are not interchangeable measurements.
