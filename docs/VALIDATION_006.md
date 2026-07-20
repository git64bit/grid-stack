# Batch 006 Validation

## Static checks performed

- all `.scad` delimiters are balanced;
- every `include` and `use` target exists;
- no `.scad` file exceeds 500 lines;
- public and private function/module names are unique;
- saved first-layer constructor and index counts agree;
- the reference trace records independently expand to the expected ordered path;
- reference trace lengths are `20, 18, 11, 9, 15 mm`;
- reference repeat distances are `5, 10, 1, 2 mm`;
- package ZIP integrity passes.

## OpenSCAD acceptance test

OpenSCAD was not available in the build environment. Final acceptance therefore requires:

1. open `first-layer-0u2Z-anyXY.scad`;
2. press F5 with `render_mode = "path_debug"` and confirm the visibly irregular route;
3. set `render_mode = "trace_layer"` and press F6;
4. confirm the geometry is one continuous `0.4 × 0.2 mm` layer with square ends and no numbers;
5. slice and inspect that the slicer preserves one continuous extrusion path.
