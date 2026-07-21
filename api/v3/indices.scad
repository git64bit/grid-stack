//////////////////////////////////////////////////////////////////////
// LibFile: indices.scad
// Project: Grid Stack
// FileGroup: API v3 Data Model
// FileSummary: Named indexes for immutable structural-coupon records.
// Role: Prevents unexplained numeric indexes from entering saved recipes and
//       keeps API version 3 independent of mutable workbench indexes.
// Exports: MAT3_*, NZ3_*, PRN3_*, PX3_*, B3_*, and SCO_* constants.
//////////////////////////////////////////////////////////////////////

MAT3_NAME = 0;
MAT3_FAMILY = 1;
MAT3_FLEXIBILITY = 2;
MAT3_STATUS = 3;
MAT3_NOTES = 4;

NZ3_NAME = 0;
NZ3_DIAMETER = 1;
NZ3_CONSTRUCTION = 2;
NZ3_STATUS = 3;
NZ3_NOTES = 4;

PRN3_NAME = 0;
PRN3_MANUFACTURER = 1;
PRN3_MODEL = 2;
PRN3_MOTION_SYSTEM = 3;
PRN3_BUILD_SURFACE = 4;
PRN3_STATUS = 5;
PRN3_NOTES = 6;

PX3_NAME = 0;
PX3_MATERIAL = 1;
PX3_NOZZLE = 2;
PX3_PRINTER = 3;
PX3_LAYER_H = 4;
PX3_WIDTH_PASSES = 5;
PX3_HEIGHT_PASSES = 6;
PX3_BRIDGE_MAX = 7;
PX3_QUALIFICATION = 8;
PX3_REVISION = 9;
PX3_NOTES = 10;

B3_NAME = 0;
B3_CELLS_X = 1;
B3_CELLS_Y = 2;
B3_CLEAR_SPAN_X = 3;
B3_CLEAR_SPAN_Y = 4;
B3_NOTES = 5;

SCO_NAME = 0;
SCO_REVISION = 1;
SCO_REQUIRED_API = 2;
SCO_SCHEMA_VERSION = 3;
SCO_SOURCE_RELEASE = 4;
SCO_FRAMEWORK_BASE_COMMIT = 5;
SCO_MATERIAL = 6;
SCO_NOZZLE = 7;
SCO_PRINTER = 8;
SCO_PROCESS = 9;
SCO_BOUNDARY = 10;
SCO_CLEAR_GAP = 11;
SCO_LEAD_IN = 12;
SCO_SUPPORT_STRATEGY = 13;
SCO_STATUS = 14;
SCO_NOTES = 15;
