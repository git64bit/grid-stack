# Data Model

## Environment records

### Material specification

Identifies a filament family such as PLA+ or TPU. It contains no nozzle or layer dimensions.

### Nozzle specification

Identifies installed hardware and its nominal diameter. Changing nozzle diameter changes the trace-width basis.

### Process profile

Joins material and nozzle with layer height, pass composition, bridge observation, qualification, and revision.

Process profiles are immutable by convention. Add a new named revision when the environment changes.

## Derived process dimensions

`lib/process_math.scad` derives:

- trace width;
- trace height;
- structural strand width;
- structural strand height.

These values are not duplicated in configuration.

## Boundary records

Both boundary constructors produce the same record layout but establish different authoritative inputs.

### Dimension boundary

Stores explicit outside dimensions. Grid count will be derived later.

### Count boundary

Stores clear-opening count and clear span. Outside dimensions are derived using the active structural strand width.

## Pattern records

Pattern topology remains independent from dimensions. Each zone declares whether its spacing comes from:

- a fixed strand pitch;
- the selected count boundary's clear span.

## Stack schedules

A stack schedule contains ordered `strand_group()` records. Each group stores:

- orientation;
- completed structural-strand count;
- pattern-set reference;
- clear vertical gap after the group.

Raw deposited-layer count and total height are derived from the active process.

## Coupon series

A coupon series references lists of count boundaries and stack schedules. Their Cartesian product defines every planned coupon case without duplicating records.

## Project specification

A project references one process profile, boundary, path policy, pattern set, and stack schedule.

## Saved Grid Stack object

`grid_stack_object()` is the top-level permanent recipe record. It embeds:

- object identity and revision;
- required API version;
- object-schema version;
- source release;
- material record;
- nozzle record;
- process record;
- boundary record;
- path-policy record;
- pattern-set record;
- stack-schedule record;
- path orientation;
- lifecycle status and notes.

The embedded records make the recipe independent of mutable configuration catalogs. The object remains a record-like vector, with field positions defined by `GSO_*` indexes in `lib/indices.scad`.

## Version distinction

The API version defines the public callable contract. The object-schema version defines the saved record layout. The release documents a project milestone. The Git commit or tag identifies the exact implementation.
