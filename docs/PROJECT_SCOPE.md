# Project Scope

Grid Stack generates printable open-grid structures from explicit continuous-nozzle-path rules.

## Primary invariant

Every deposited layer is exactly one open continuous path with no internal lift, travel move, disconnected island, or independent closed loop.

## Active geometry grammar

The current shared grid engine provides:

- rectangular count boundaries;
- independent X/Y cell counts and clear spans;
- parallel traces with perpendicular square connectors and square ends;
- alternating X/Y deposited layers in direct contact;
- outside dimensions derived from the count boundary and deposited trace size.

The variable parallel-trace First Layer workbench is a separate supported grammar.

## Workbench rule

Coupon and Laboratory variations are Customizer presets applied to generic generators. Hard-coded matrices and one-file-per-experiment source generation are outside the active workflow.

## Promotion rule

A preset remains mutable until it is physically tested and accepted. Promotion creates an immutable `.scad` recipe and a Catalog registration. Slicer-only settings belong in the associated 3MF manufacturing project.

## Project boundary

Circles, polygons, hex fields, mixed topologies, curved terminations, disconnected paths, and intentional layer separation are not partially implemented in this framework. A conflicting topology or geometry grammar belongs in another project.
