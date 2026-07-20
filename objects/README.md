# Saved Objects

Every accepted Grid Stack object receives a dedicated top-level `.scad` recipe.

A saved recipe must:

- import an explicit file under `api/`;
- assert its required API and object schema;
- embed exact geometry-affecting records;
- record its source release and accepted source commit;
- avoid Customizer state and mutable catalog lookup;
- call exactly one public rendering module;
- receive a new filename and revision after a printed version changes.

## Current groups

- `coupon_3x3_span6_gap2_v1.scad` — API v1 stack/coupon record and diagnostic path.
- `first-layer-0u2Z-variable-50x18-v1.scad` — API v1 calibration recipe.
- `printed/` — API v2 immutable PLA+ and TPU recipes reported successful.

The planned twelve structural span/gap coupons remain deferred until their printable stack geometry exists.
