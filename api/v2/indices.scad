//////////////////////////////////////////////////////////////////////
// LibFile: indices.scad
// Project: Grid Stack
// FileGroup: API v2 Data Model
// FileSummary: Field indexes for immutable first-layer print records.
// Role: Keeps API v2 records readable without coupling them to the older
//       structural-strand schema used by Grid Stack API version 1.
// Exports: Material, nozzle, printer, trace-process, parallel-trace, and
//          saved first-layer field-index constants.
//////////////////////////////////////////////////////////////////////

// Material identity
MAT_NAME = 0;
MAT_FAMILY = 1;
MAT_FLEXIBILITY = 2;
MAT_STATUS = 3;
MAT_NOTES = 4;

// Nozzle hardware
NZ_NAME = 0;
NZ_DIAMETER = 1;
NZ_CONSTRUCTION = 2;
NZ_STATUS = 3;
NZ_NOTES = 4;

// Printer hardware
PRN_NAME = 0;
PRN_MANUFACTURER = 1;
PRN_MODEL = 2;
PRN_MOTION_SYSTEM = 3;
PRN_BUILD_SURFACE = 4;
PRN_STATUS = 5;
PRN_NOTES = 6;

// Single-trace process
TP_NAME = 0;
TP_MATERIAL = 1;
TP_NOZZLE = 2;
TP_PRINTER = 3;
TP_LAYER_H = 4;
TP_QUALIFICATION = 5;
TP_REVISION = 6;
TP_NOTES = 7;

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
FLO_SOURCE_COMMIT = 5;
FLO_MATERIAL = 6;
FLO_NOZZLE = 7;
FLO_PRINTER = 8;
FLO_PROCESS = 9;
FLO_TRACES = 10;
FLO_ORIENTATION = 11;
FLO_LEAD_IN = 12;
FLO_STATUS = 13;
FLO_NOTES = 14;
