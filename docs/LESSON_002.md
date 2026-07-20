
# Lesson 002 — The Printing Environment and the Structural Strand

## Separate identity from qualification

`config/materials.scad` lists material families currently known to the project. It does not claim that every material is ready for Grid Stack.

`config/nozzles.scad` lists physical nozzle hardware. Nozzle diameter is the width basis for one trace.

`config/process_profiles.scad` records one exact, tested combination of:

- material;
- nozzle;
- layer height;
- horizontal pass count;
- vertical pass count;
- maximum unsupported span;
- qualification and revision.

Changing any one of these creates a new environment. Add a new process profile rather than silently editing the old profile.

## Trace versus structural strand

A trace is what one nozzle pass deposits. It is not considered reliable by itself.

For the reference profile:

```text
trace width  = 0.4 mm nozzle
trace height = 0.2 mm deposited layer
```

A structural strand is composed from at least two traces in width and two layers in height:

```text
strand width  = 0.4 × 2 = 0.8 mm
strand height = 0.2 × 2 = 0.4 mm
```

Both values are derived in `lib/process_math.scad`; they are not independently entered.

## Why TPU is listed but not selectable

TPU is a current project material, so it belongs in the material catalog. It does not yet have a qualified Grid Stack bridge profile. This distinguishes **known material** from **validated environment**.

## Clear gap

Clear gap is still useful as a geometric report:

```text
clear gap = strand pitch − composed strand width
```

Batch 002 removes provisional minimum and maximum clear-gap constraints. Grout-flow openings and unsupported bridge spans are different concepts and will be specified separately when their geometry is defined.
