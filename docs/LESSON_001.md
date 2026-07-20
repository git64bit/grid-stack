
# Lesson 001 — Records, Tables, and Orchestration

OpenSCAD does not provide a native struct type. Grid Stack therefore uses **record-like vectors** stored in lists.

```scad
MATERIALS = [
    material_spec(
        name = "PLA_PLUS",
        family = "PLA+",
        flexibility = "rigid",
        status = "in_use"
    )
];
```

This expression contains three levels:

1. `MATERIALS` is a named table.
2. `[ ... ]` is a list of records.
3. `material_spec(...)` is a constructor function returning one ordered vector.

The constructor call is readable because it uses named arguments. Internally it returns a positional vector. `lib/indices.scad` gives each position a stable name.

## Why this matters

The initialization environment is not incidental. A project upgrade may add a material, nozzle, or tested process without rewriting geometry. Existing names remain stable, and a project references one exact process profile.

## Orchestration chain

Trace the selected process through the files:

```text
project name
  → project record
  → process-profile name
  → process record
  → material record + nozzle record
  → validation
  → derived dimensions
  → report
```

`main.scad` coordinates that chain. It does not own the numbers and does not know the vector indexes.

## Standard source headers

Every `.scad` file now begins with a BOSL2-inspired header containing:

- `LibFile`;
- `Project`;
- `FileGroup`;
- `FileSummary`;
- `Role`;
- dependencies and exports where applicable.

Public constructor and process-math functions also include `Function`, `Synopsis`, and argument documentation.
