# Development Roadmap

## Completed OpenSCAD framework

- explicit material, nozzle, process, boundary, path, and project records;
- continuous rectangular path generation;
- alternating direct-contact deposited layers;
- preset-native Coupon and Laboratory workbenches;
- preset-native variable-trace First Layer workbench;
- separate Catalog registry;
- immutable saved-object API pattern;
- retirement of the hard-coded coupon matrix and positive-gap coupon implementation.

## Current stable phase

The OpenSCAD framework is complete for the current rectangular grammar. Changes should now be limited to defects, workbench additions that use the existing grammar, and promotion of physically accepted presets into immutable Catalog objects.

## Next application phase

The web application should reproduce the workbench and preset workflow, generate or consume OpenSCAD parameter sets, expose Catalog objects, and associate accepted geometry with slicer 3MF manufacturing projects.

A topology or geometry grammar that conflicts with the current continuous rectangular contract belongs in a separate project or a deliberately versioned future framework.
