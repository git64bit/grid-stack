//////////////////////////////////////////////////////////////////////
// LibFile: indices.scad
// Project: Grid Stack
// FileGroup: Data Model
// FileSummary: Named indexes for record-like vectors constructed in schema.scad.
// Role: Prevents unexplained numeric indexes from spreading through the code.
// Exports: Field-index constants for every record type.
//////////////////////////////////////////////////////////////////////

// Material specification
MAT_NAME = 0;
MAT_FAMILY = 1;
MAT_FLEXIBILITY = 2;
MAT_STATUS = 3;
MAT_NOTES = 4;

// Nozzle specification
NZ_NAME = 0;
NZ_DIAMETER = 1;
NZ_CONSTRUCTION = 2;
NZ_STATUS = 3;
NZ_NOTES = 4;

// Process profile
PX_NAME = 0;
PX_MATERIAL = 1;
PX_NOZZLE = 2;
PX_LAYER_H = 3;
PX_WIDTH_PASSES = 4;
PX_HEIGHT_PASSES = 5;
PX_BRIDGE_MAX = 6;
PX_QUALIFICATION = 7;
PX_REVISION = 8;
PX_NOTES = 9;

// Boundary specification
B_NAME = 0;
B_MODE = 1;
B_KIND = 2;
B_SIZE_X = 3;
B_SIZE_Y = 4;
B_CELLS_X = 5;
B_CELLS_Y = 6;
B_CLEAR_SPAN_X = 7;
B_CLEAR_SPAN_Y = 8;
B_SIDES = 9;
B_ROTATION = 10;
B_EDGE_MARGIN = 11;
B_NOTES = 12;

// Path policy
PP_NAME = 0;
PP_LEAD_IN = 1;
PP_LEAD_OUT = 2;
PP_REQUIRE_CONTINUOUS = 3;
PP_ALLOW_TRAVEL = 4;
PP_ALLOW_LIFT = 5;
PP_ALLOW_CLOSED_SUBPATHS = 6;
PP_START_RULE = 7;
PP_END_RULE = 8;
PP_NOTES = 9;

// Pattern zone
Z_NAME = 0;
Z_PATTERN = 1;
Z_BAND_KIND = 2;
Z_BAND_VALUE = 3;
Z_SPACING_SOURCE = 4;
Z_STRAND_PITCH = 5;
Z_CONNECTOR = 6;
Z_NOTES = 7;

// Pattern set
PS_NAME = 0;
PS_ZONES = 1;
PS_TRANSITION = 2;
PS_NOTES = 3;

// Structural-strand group
SG_ORIENTATION = 0;
SG_STRAND_COUNT = 1;
SG_PATTERN_SET = 2;
SG_CLEAR_GAP_AFTER = 3;
SG_NOTES = 4;

// Stack schedule
SS_NAME = 0;
SS_GROUPS = 1;
SS_REQUIRE_SYMMETRY = 2;
SS_NOTES = 3;

// Project specification
PR_NAME = 0;
PR_PROCESS = 1;
PR_BOUNDARY = 2;
PR_PATH_POLICY = 3;
PR_PATTERN_SET = 4;
PR_SCHEDULE = 5;
PR_NOTES = 6;

// Coupon series
CS_NAME = 0;
CS_PROCESS = 1;
CS_BOUNDARIES = 2;
CS_SCHEDULES = 3;
CS_PATH_POLICY = 4;
CS_PATTERN_SET = 5;
CS_NOTES = 6;
