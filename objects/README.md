# Saved Objects

Every printed Grid Stack object receives a dedicated top-level `.scad` recipe.

A saved recipe must:

- import an explicit file under `api/`;
- assert its required API and object schema;
- embed exact material, nozzle, process, and geometry records;
- avoid Customizer state and mutable catalog lookup;
- call exactly one public rendering module;
- receive a new filename and revision after a printed version changes.

Current examples:

- `coupon_3x3_span6_gap2_v1.scad` — saved stack/coupon record and diagnostic path.
- `first-layer-0u2Z-variable-50x18-v1.scad` — printable variable parallel first layer.
