# Path Generators

Path files return ordered XY centerlines. They do not create printable solids.

- `rectangular_serpentine.scad` derives a regular coupon path from boundary and strand data.
- `parallel_traces.scad` derives a path from explicit parallel-trace records. Every trace length and repeat distance may differ, while endpoint alignment preserves square perpendicular turns.

Printable geometry consumes these ordered point lists from `geometry/`.
