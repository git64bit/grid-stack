
# Documentation Standard

Grid Stack uses a BOSL2-inspired source-documentation style.

Every `.scad` file begins with a header containing:

```text
LibFile
Project
FileGroup
FileSummary
Role
Requires / Includes
Exports
```

Public functions should additionally document:

```text
Function
Synopsis
Description, when needed
Arguments, when the signature is not self-evident
```

The purpose is not decorative completeness. It allows a reader to establish a file's role before reading implementation details and makes environment changes traceable.
