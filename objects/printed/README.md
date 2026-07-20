# Printed First-Layer Objects

These files are immutable geometry recipes promoted from the accepted variable parallel-trace design at commit `79f36da`.

| Recipe | Material | Nozzle | Layer | Status |
|---|---:|---:|---:|---|
| `first-layer-0u2Z-variable-50x18-pla-plus-0p4-v1.scad` | PLA+ | 0.4 mm | 0.2 mm | Reported printed successfully |
| `first-layer-0u2Z-variable-50x18-tpu-0p4-v1.scad` | TPU | 0.4 mm | 0.2 mm | Reported printed successfully |

The trace geometry is identical. Separate files are required because changing material changes the printing environment even when the object dimensions do not change.

The printer hardware was not identified when these records were created. Each recipe records that fact explicitly rather than inventing a printer model. Future printed recipes should use a named `printer_spec()` record with the actual machine and build surface.

Do not edit a printed recipe. A changed material, nozzle, printer, layer height, trace sequence, or lead-in receives a new filename and revision.
