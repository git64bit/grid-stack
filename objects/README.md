# Saved Objects

Every accepted Grid Stack object receives a dedicated top-level `.scad` recipe.

A saved recipe must:

- import an explicit versioned API under `api/`;
- assert its required API and object schema;
- embed exact geometry-affecting environment and object records;
- avoid Customizer state and mutable catalog lookup;
- call exactly one public rendering module;
- receive a new filename and revision after any printed version changes.

## Current groups

- `printed/` — immutable PLA+ and TPU first-layer objects using API version 2.
- `coupons/` — complete rectangular structural-coupon set using API version 3.
- `coupon_3x3_span6_gap2_v1.scad` — historical API v1 diagnostic recipe retained unchanged.
- `first-layer-0u2Z-variable-50x18-v1.scad` — historical API v1 recipe retained unchanged.

## Commit identity

A recipe cannot embed the hash of the future Git commit that will contain it. API version 3 therefore records the accepted framework base commit, while the containing repository commit remains the authoritative complete source.
