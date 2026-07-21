//////////////////////////////////////////////////////////////////////
// LibFile: indices.scad
// Project: Grid Stack
// FileGroup: Data Model
// FileSummary: Named indexes for record-like vectors constructed in schema.scad.
// Role: Prevents unexplained numeric indexes from spreading through the code.
// Exports: Field-index constants for every record type, including frozen path-
//          layer terminology, compatibility aliases, and saved objects.
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

// Structural path-layer group
//
// PLG_* is the frozen terminology. One group count represents repetitions of
// one complete continuous serpentine grid layer. SG_* remains as a compatibility
// alias for API v1 and the early lessons, where the field was named strand_count.
PLG_ORIENTATION = 0;
PLG_LAYER_COUNT = 1;
PLG_PATTERN_SET = 2;
PLG_CLEAR_GAP_AFTER = 3;
PLG_NOTES = 4;

SG_ORIENTATION = PLG_ORIENTATION;
SG_STRAND_COUNT = PLG_LAYER_COUNT;
SG_PATTERN_SET = PLG_PATTERN_SET;
SG_CLEAR_GAP_AFTER = PLG_CLEAR_GAP_AFTER;
SG_NOTES = PLG_NOTES;

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

// Saved Grid Stack object
GSO_NAME = 0;
GSO_REVISION = 1;
GSO_REQUIRED_API = 2;
GSO_SCHEMA_VERSION = 3;
GSO_SOURCE_RELEASE = 4;
GSO_MATERIAL = 5;
GSO_NOZZLE = 6;
GSO_PROCESS = 7;
GSO_BOUNDARY = 8;
GSO_PATH_POLICY = 9;
GSO_PATTERN_SET = 10;
GSO_SCHEDULE = 11;
GSO_PATH_ORIENTATION = 12;
GSO_STATUS = 13;
GSO_NOTES = 14;

// Parallel-trace record
PTR_AXIS_MIN = 0;
PTR_AXIS_MAX = 1;
PTR_OFFSET = 2;

// Saved first-layer object
FLO_NAME = 0;
FLO_REVISION = 1;
FLO_REQUIRED_API = 2;
FLO_SCHEMA_VERSION = 3;
FLO_SOURCE_RELEASE = 4;
FLO_MATERIAL = 5;
FLO_NOZZLE = 6;
FLO_PROCESS = 7;
FLO_TRACES = 8;
FLO_ORIENTATION = 9;
FLO_LEAD_IN = 10;
FLO_STATUS = 11;
FLO_NOTES = 12;
