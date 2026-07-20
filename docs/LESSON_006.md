# Lesson 006 — Data First, Geometry Second

## 1. Define the domain record

The path is not stored as an unexplained list of every XY turn. It is stored as the engineering objects being controlled: parallel traces.

```scad
traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];
```

One record means:

```text
[axis_min, axis_max, perpendicular_position]
```

The trace length is `axis_max - axis_min`. The repeat distance is the difference between consecutive perpendicular positions.

No common length or common repeat value exists unless the records explicitly contain one.

## 2. Separate description from traversal

The records store geometric extents in ascending order. They do not store nozzle direction.

Traversal is derived by index:

```text
even trace: minimum → maximum
odd trace:  maximum → minimum
```

This produces one continuous alternating route while keeping every record readable as a physical extent.

## 3. Square turns require a contract

A perpendicular connector can remain square only when the current traversal endpoint equals the next traversal start coordinate.

The reference sequence satisfies:

```text
10 = 10
-8 = -8
3 = 3
-6 = -6
```

Validation rejects a record sequence that would require a diagonal or idle move.

## 4. Variable repeat is explicit

The perpendicular positions are:

```text
0, 5, 15, 16, 18
```

Therefore the centerline repeat distances are:

```text
5, 10, 1, 2 mm
```

With a `0.4 mm` trace, the corresponding clear gaps are:

```text
4.6, 9.6, 0.6, 1.6 mm
```

This is visibly not a square wave.

## 5. Geometry is a consumer

`parallel_trace_path()` converts the records into ordered XY points. `printable_trace_layer()` consumes those points and creates rectangular trace geometry.

The layers remain separate:

```text
trace records
    ↓
ordered continuous path
    ↓
validated square trace geometry
```

The path generator does not create solids. The geometry module does not decide trace spacing or length.

## 6. Customizer records

The development entry point exposes each trace as one three-number vector:

```scad
trace_01 = [-10, 10, 0];
trace_02 = [ -8, 10, 5];
```

It then assembles the active records into the authoritative nested `traces` list. This keeps each editable control small while preserving the saved-object format selected for the project.

## 7. Development file versus saved object

Edit `first-layer-0u2Z-anyXY.scad` while experimenting. Once a configuration is accepted, copy the exact records and environment into a versioned file under `objects/`.

The saved object imports an explicit API, asserts the API and first-layer schema, embeds the exact material/nozzle/process records, and calls one public render module.

## Exercise

Open `first-layer-0u2Z-anyXY.scad` and switch between:

```scad
render_mode = "path_debug";
render_mode = "trace_layer";
```

Then change one unconnected endpoint while preserving the shared turn endpoint. The trace length changes without changing its repeat distance. Next change one perpendicular position and the repeat distance changes without forcing any other repeat to match it.
