# Project Scope

Grid Stack generates printable open-grid structures from explicit nozzle-path rules.

## Primary invariant

Every deposited layer must be representable as exactly one open, continuous path from lead-in to final endpoint.

The design must not require:

- nozzle lifts inside the path;
- non-extruding travel moves inside the path;
- disconnected islands;
- independently closed loops;
- slicer-created seams as a normal part of the pattern.

## Process constraints

The initial PLA+ process model records:

- 0.4 mm nozzle;
- 0.4 mm nominal line width;
- 0.2 mm layer height;
- 0.8 mm bridge strand width;
- 6 mm maximum unsupported span;
- two layers required to establish the full bridge strand.

These are process facts, not decorative dimensions. Later geometry must derive from them or validate against them.

## Out of scope for Batch 001

- path generation;
- polygon clipping;
- square-to-hex transitions;
- STL generation;
- slicer ordering guarantees;
- material performance claims.
