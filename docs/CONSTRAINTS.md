# Constraints Register

## Accepted observations

| Constraint | Initial value | Status |
|---|---:|---|
| Nozzle diameter | 0.4 mm | Reference process |
| Layer height | 0.2 mm | Reference process |
| Bridge strand width | 0.8 mm | Reference process |
| Maximum unsupported PLA+ span | 6.0 mm | User-observed limit |
| Bridge completion | 2 layers | User-observed behavior |
| Paths per deposited layer | 1 | Hard invariant |
| Internal travel moves | 0 | Hard invariant |
| Internal nozzle lifts | 0 | Hard invariant |
| Closed independent subpaths | 0 | Hard invariant |

## Provisional values requiring coupons

| Constraint | Initial value |
|---|---:|
| Minimum clear opening | 0.8 mm |
| Maximum clear opening | 6.0 mm |
| Tutorial strand pitch | 4.0 mm |

The maximum clear opening currently equals the bridge limit. Later pattern geometry may distinguish clear opening from actual unsupported span.
