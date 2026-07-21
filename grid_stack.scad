//////////////////////////////////////////////////////////////////////
// LibFile: grid_stack.scad
// Project: Grid Stack
// FileGroup: Workbench Foundation
// FileSummary: Loads the legacy API v1 record model and shared mathematics used
//              by current development entry points.
// Role: Convenience foundation for mutable workbench files only. Permanent
//       objects must import an explicit versioned API file. The frozen coupon
//       API will be published after positive-gap geometry is accepted.
// Exports: API v1 constructors, indexes, mathematics, and diagnostic modules.
//////////////////////////////////////////////////////////////////////

include <api/grid_stack_v1.scad>
