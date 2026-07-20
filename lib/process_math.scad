//////////////////////////////////////////////////////////////////////
// LibFile: process_math.scad
// Project: Grid Stack
// FileGroup: Process Mathematics
// FileSummary: Derives trace and structural-strand dimensions from an exact
//              process profile and nozzle specification.
// Role: Keeps composed dimensions rational and prevents independent values
//       from drifting out of agreement.
// Requires: Field indexes from lib/indices.scad.
// Exports: trace_width(), trace_height(), strand_width(), strand_height().
//////////////////////////////////////////////////////////////////////

// Function: trace_width()
// Synopsis: Returns the width basis of one nozzle pass.
function trace_width(nozzle) = nozzle[NZ_DIAMETER];

// Function: trace_height()
// Synopsis: Returns the height of one deposited layer in the process profile.
function trace_height(process) = process[PX_LAYER_H];

// Function: strand_width()
// Synopsis: Returns the composed structural width from two or more passes.
function strand_width(process, nozzle) =
    trace_width(nozzle) * process[PX_WIDTH_PASSES];

// Function: strand_height()
// Synopsis: Returns the composed structural height from two or more layers.
function strand_height(process) =
    trace_height(process) * process[PX_HEIGHT_PASSES];
