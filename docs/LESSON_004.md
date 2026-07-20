# Lesson 004 — One Ordered Nozzle Path

## The path is data before it is geometry

The first generated object is not a solid. It is an ordered list of XY points:

```scad
points = [
    [-29.6, 0.4],
    [0.4, 0.4],
    [17.8, 0.4],
    [17.8, 6.2],
    [0.4, 6.2],
    [0.4, 12.0],
    [17.8, 12.0],
    [17.8, 17.8],
    [0.4, 17.8]
];
```

Every adjacent point pair is one uninterrupted segment. Because the list is
ordered, it has one start, one end, and no separate island.

## Why path generation belongs in `paths/`

`main.scad` selects the environment and boundary. It does not know how to make
a serpentine route. Instead it delegates to:

```text
paths/rectangular_serpentine.scad
```

That file accepts records and returns points. It does not choose a project,
read Customizer values, or create a solid.

This separation allows the same generator to be tested with another material,
nozzle, clear span, or coupon count without rewriting its algorithm.

## Count-driven coupon geometry

The selected 3 × 3 coupon has four structural-strand centerlines in each axis.
For an X-running layer, four horizontal runs are connected by three vertical
square turns:

```text
runs       = cells_y + 1 = 4
connectors = runs - 1    = 3
```

The path also contains one lead-in. No perimeter border is generated.

## Why the lead-in is point zero

The lead-in starts outside the coupon envelope and joins the first run without
a lift or idle move. Point zero is therefore outside the envelope, while point
one is the first structural-strand centerline inside it.

For the active policy:

```text
lead-in length = 30 mm
```

The green preview marker is the single start. The red marker is the single end.

## Square turns are ordinary path segments

A square turn is not a special solid. It is the connector segment between two
parallel runs. The end of one run and the start of the next share the same
ordered path.

This matters because disconnected line geometry could force the slicer to lift
and travel. The ordered centerline instead describes one uninterrupted route.

## Validation before solid generation

`lib/path_validation.scad` checks:

- the expected point count;
- no repeated consecutive points;
- only horizontal and vertical segments;
- exact lead-in length;
- an open path with different start and end points;
- a lead-in start outside the coupon envelope.

A passing model reports:

```text
GRID STACK GENERATED PATH VALIDATION: PASS
```

## Diagnostic geometry is not the strand

`geometry/path_preview.scad` gives the point list a deliberately thin visible
line. It also shows point numbers and a translucent boundary reference.

This is not the 0.8 × 0.4 mm structural strand. Converting the path into the
composed printable strand remains a later lesson.

## Change the orientation, not the algorithm

Customizer accepts:

```text
path_orientation = 0    X-running rows
path_orientation = 90   Y-running columns
```

Both selections use the same rules: one lead-in, one ordered path, square
connectors, one open end.

## Lesson result

Batch 004 produces the first auditable continuous-path definition. The design
sequence is now:

```text
qualified process environment
        ↓
count-driven boundary
        ↓
ordered centerline points
        ↓
path validation
        ↓
diagnostic preview
```
