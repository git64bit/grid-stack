
# Data Model

## Material specification

A material record identifies a filament family such as PLA+ or TPU. It contains no nozzle or layer dimensions.

## Nozzle specification

A nozzle record identifies installed hardware and its nominal diameter. Changing diameter changes the trace-width basis.

## Process profile

A process profile is the exact qualified environment that joins material and nozzle with layer height, pass composition, bridge observation, qualification, and revision.

Process profiles are immutable by convention. Add a new named revision when the environment changes.

## Derived dimensions

`lib/process_math.scad` derives:

- trace width;
- trace height;
- composed strand width;
- composed strand height.

These values are not duplicated in configuration.

## Boundary, path policy, pattern set, and schedule

These remain independent from the printing environment. The same path policy or boundary can be tested under multiple exact process profiles.

## Project specification

A project references one process profile and the named geometry-policy records required for generation.
