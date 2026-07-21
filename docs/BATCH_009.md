# Batch 009 — Rectangular framework audit and freeze

Base commit: `06f7cdd`

## Audit corrections

- Removed the hardcoded Batch 008 project check from `main.scad`.
- Generated the complete twelve-case positive-gap project catalog.
- Preserved the accepted 6 mm direct-contact coupon as a separate reference.
- Corrected schedule terminology from individual strand count to complete structural path-layer count.
- Allowed 7 and 8 mm exploratory spans instead of rejecting them at the 6 mm qualification boundary.
- Centralized the supported rectangular framework contract.
- Added explicit stubs for dimension boundaries, non-rectangular contours, mixed patterns, expanded schedules, and positive-gap support geometry.
- Separated valid positive-gap specifications from currently printable geometry.

## Framework status

The rectangular record model, naming rules, count-boundary mathematics, path-layer schedule, and direct-contact path generator are ready to freeze.

Positive-gap support remains the sole missing geometry required before publishing the immutable coupon API and generating the permanent recipe set.
