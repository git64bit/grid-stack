# Development Roadmap

## Completed

- Batch 001: specification and record model.
- Batch 002: materials, nozzles, and qualified process profiles.
- Batch 003: count and dimension boundary records; coupon matrix specification.
- Batch 004: first continuous rectangular path.
- Batch 005: saved-object contract and API version assertion.
- Batch 006: variable parallel first-layer traces.
- Batch 007: immutable PLA+ and TPU first-layer recipes.
- Batch 008: accepted direct-contact structural coupon.
- Batch 009: rectangular framework audit and freeze.

## Batch 010

Design and qualify the positive-gap anchor/support geometry, publish an isolated rectangular coupon API, and generate the permanent recipe set:

```text
4 XY spans × 3 Z gaps = 12 coupons
plus the accepted 6 mm / 0 mm reference
```

## Deferred stubs

- dimension-envelope fitting;
- circular boundaries;
- regular and custom polygon boundaries;
- mixed square/hex pattern zones;
- expanded 4-5-6-5-4 path-layer schedules;
- other connector strategies.

Deferred features remain visible in code and documentation but do not compete with rectangular coupon completion.
