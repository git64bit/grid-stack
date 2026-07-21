# Lesson 009 — Freeze contracts before multiplying objects

A generator should not create a large permanent object set until its terms have one stable meaning.

## The audit question

The early schedule field was named `strand_count`. The implemented geometry did not repeat individual parallel strands. It repeated a complete serpentine grid path using a structural-strand cross-section.

That difference matters:

```text
strand            one parallel or connecting section of the path
path layer         the complete continuous serpentine at one structural level
raw layer          one slicer deposition height
```

The new constructor makes the intended unit explicit:

```scad
path_layer_group(
    orientation = 0,
    layer_count = 1,
    pattern_set_name = "SQUARE_COUPON",
    clear_gap_after = 2
);
```

The compatibility constructor remains available, but new framework code should not use it:

```scad
strand_group(...);  // legacy API v1 name
```

## Specification versus implementation

A 2 mm vertical gap can be a valid record before printable support geometry exists. Validation therefore answers two separate questions:

1. Is this a coherent rectangular coupon specification?
2. Does the current generator know how to print it?

The first may pass while the second remains a deliberate stub. This is safer than producing a floating solid that appears complete but cannot be manufactured as intended.

## Why exploratory values remain valid

The process profile records a 6 mm owner-tested bridge limit. Coupons at 7 and 8 mm exist specifically to observe failure. They should be labeled exploratory, not rejected as malformed.

A qualification limit describes current knowledge. It is not always a geometric maximum.

## Framework freeze

After this lesson, the urgent coupon framework has one supported route:

```text
qualified process
    ↓
count_boundary rectangle
    ↓
continuous square serpentine paths
    ↓
complete structural path layers
    ↓
validated coupon specification
    ↓
direct-contact output or explicit positive-gap stub
```

Future boundary and pattern concepts remain named, but cannot enter this route until implemented and tested.
