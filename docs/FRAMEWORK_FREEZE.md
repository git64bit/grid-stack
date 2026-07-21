# Rectangular Framework Freeze 1

Batch 009 freezes the architecture and terminology required for the urgent rectangular coupon series. It does not claim that every frozen specification is printable yet.

## Supported core

The active framework accepts only:

```text
count_boundary()
rectangle
SQUARE_COUPON
square turns
one continuous open path per deposited layer
one complete lower X grid layer
one complete upper Y grid layer
nonnegative clear Z gap
```

The boundary counts clear openings. A `3 × 3` boundary therefore contains four parallel structural runs in each direction.

## Corrected schedule unit

A schedule count does **not** mean one individual parallel strand. It means one complete continuous structural **path layer** covering the entire boundary.

```text
primitive trace                 0.4 × 0.2 mm
composed structural strand      0.8 × 0.4 mm
complete structural path layer  one continuous serpentine using that section
```

The frozen coupon schedule is therefore:

```text
one complete X path layer
clear vertical gap
one complete Y path layer
```

`path_layer_group()` is the correct constructor. `strand_group()` and the `SG_*` indexes remain compatibility aliases for API v1 and early lessons.

## Coupon catalog

The matrix contains twelve positive-gap specifications:

```text
XY clear span: 5, 6, 7, 8 mm
Z clear gap:   1, 2, 3 mm
count:         3 × 3 clear openings
```

The accepted `6 mm / 0 mm` direct-contact print is a separate reference, giving thirteen named projects in total.

Spans above the current 6 mm owner-tested bridge limit are valid exploratory coupons. They are reported as beyond the tested limit rather than rejected.

## Printable status

The direct-contact reference is implemented.

Positive-gap specifications are validated, named, dimensioned, and reportable, but their anchor/support geometry is an explicit stub. They must not silently render as unsupported floating solids.

## Deferred stubs

The following names remain in the project but are not active framework features:

- dimension-envelope boundaries;
- circular boundaries;
- regular and custom polygon boundaries;
- mixed square/hex patterns;
- the expanded 4-5-6-5-4 schedule;
- positive-gap anchor/support geometry.

Selecting a deferred project fails with a specific assertion rather than falling through to an unrelated generator.

## API audit finding

API versions 1 and 2 import some shared files. Their assertions identify a version, but those implementations are not fully isolated from later shared-library changes.

The complete coupon set will use a new versioned API only after positive-gap geometry is accepted. That API must keep its implementation dependencies under its own versioned directory so an old recipe continues to reconstruct the same object.
