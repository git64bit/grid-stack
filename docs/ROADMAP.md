# Development Roadmap

## Batch 001 — Initial specification

Named records, constraints, schedule, zones, validation, and reporting.

## Batch 002 — Printing environment

Separate materials, nozzles, and qualified process profiles; derive trace and structural-strand dimensions; standardize source headers.

## Batch 003 — Boundary and coupon model

Add dimension-driven and count-driven boundaries, structural-strand schedules, vertical clear gaps, and the 3 × 3 span/gap coupon matrix. No geometry.

## Batch 004 — First continuous coupon path

Generate one count-driven 3 × 3 rectangular square-grid centerline with one lead-in, square turns, one uninterrupted ordered point list, path validation, and a diagnostic preview.

## Batch 005 — Versioned saved-object API

Separate the development workbench from permanent object recipes. Add API and object-schema versions, self-contained embedded records, validation, reporting, and one public execution module.

## Batch 006 — Variable parallel first layer

Generate one printable primitive trace layer from independently configured parallel trace lengths and repeat distances while preserving square turns and one continuous path.

## Batch 007 — Immutable printed first-layer recipes

Promote the accepted variable trace object into separate PLA+ and TPU recipes. Add API v2 trace-process and printer records without changing API v1.

## Next

Develop the composed `0.8 × 0.4 mm` structural strand from qualified primitive traces, then create one printable two-orientation stack coupon. Generate the full twelve-case span/gap recipe set only after that geometry is accepted.

## Later batches

Dimension-envelope fitting reports, 4-5-6-5-4 stack expansion, variable spacing, connector strategies, contour-aware boundaries, and square-to-hex transitions.
