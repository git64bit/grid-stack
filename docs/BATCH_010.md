# Batch 010 — Complete Rectangular Coupon Set

Base commit: `4b5e564`

## Purpose

Complete the only geometry stub that blocked the coupon matrix, publish a versioned immutable coupon API, and create a permanent OpenSCAD recipe for every calibration object.

## Implemented geometry

The accepted zero-gap reference remains two orthogonal structural grids in direct contact.

Every positive-gap coupon uses the frozen `witness_riser_bridge` strategy:

1. one lower Y-running witness grid, including the external lead-in;
2. one X-running path extruded through the requested vertical gap;
3. one upper Y-running test grid aligned directly above the witness.

The X path becomes continuous riser walls. It is sliced into 5, 10, or 15 deposited layers for 1, 2, or 3 mm gaps at the qualified 0.2 mm layer height.

## Permanent output

`objects/coupons/` contains:

- twelve positive-gap recipes;
- one physically accepted 6 mm / 0 mm direct-contact reference;
- a matrix README.

Every recipe imports API version 3 directly and contains no mutable catalog lookup.

## Framework freeze

Rectangular framework version 2 is now complete. Future urgent work may add observations or new immutable recipes, but geometry changes require a new framework/API version.

The following remain stubs: dimension boundaries, non-rectangular boundaries, mixed square/hex patterns, and expanded schedules.
