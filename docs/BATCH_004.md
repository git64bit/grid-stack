# Batch 004 — First Continuous Coupon Path

Base repository commit: `217d0d6`

## Added

- ordered rectangular serpentine path generation;
- X-running and Y-running coupon orientations;
- one continuous 30 mm lead-in;
- square connectors without a perimeter border;
- path mathematics, validation, and console reporting;
- diagnostic path preview with point numbers and start/end markers;
- Lesson 004.

## Deliberately excluded

- printable structural-strand solids;
- full stack generation;
- dimension-driven path fitting;
- circular or polygon boundaries;
- hexagonal interior patterns;
- slicer or G-code guarantees.

The selected path is geometric intent. Slicer output must later be inspected to
confirm that it preserves the same uninterrupted extrusion order.
