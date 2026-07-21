# Batch 010 Validation

## Static checks

- all OpenSCAD delimiters are balanced;
- all local include paths resolve;
- every `.scad` file remains below 500 lines;
- thirteen immutable coupon recipes are present;
- the matrix contains exactly four spans by three positive gaps;
- every positive gap is an integer number of 0.2 mm deposited layers;
- API version 3 is isolated under `api/v3/`;
- no previously versioned API file was changed;
- the archive contains only new and changed files.

## Contract tests

Open and press F5:

```text
tests/framework_freeze_contract.scad
tests/structural_coupon_contract.scad
tests/positive_gap_coupon_contract.scad
tests/api_v3_coupon_contract.scad
```

Expected final messages:

```text
GRID STACK FRAMEWORK FREEZE CONTRACT: PASS
GRID STACK STRUCTURAL COUPON CONTRACT: PASS
GRID STACK POSITIVE-GAP COUPON CONTRACT: PASS
GRID STACK API V3 COUPON CONTRACT: PASS
```

## Required physical validation

Open one recipe under `objects/coupons/`, press F6, export, and inspect the slicer before printing. Confirm:

1. the witness has one lead-in;
2. every riser layer is one continuous X-running path;
3. the upper test grid begins on a riser crossing;
4. no support, travel path, brim, or perimeter border is silently added;
5. the selected slicer produces the intended two-pass 0.8 mm structural width.

OpenSCAD was not available in the build environment, so F5/F6 and slicer inspection remain the acceptance tests.
