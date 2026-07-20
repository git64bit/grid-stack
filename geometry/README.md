# Geometry

Geometry modules consume validated path data. They do not decide path spacing, trace length, material, or process selection.

- `path_preview.scad` produces non-printable centerline diagnostics, markers, and point numbers.
- `trace_layer.scad` produces one printable square-ended nozzle trace, extruded to one deposited-layer height.

The first-layer primitive is intentionally distinct from a composed structural strand.
