# Validation 008

## Static checks performed

- all OpenSCAD include targets exist;
- parentheses, brackets, and braces are balanced;
- no `.scad` file exceeds 500 lines;
- Batch 008 project, boundary, schedule, and render-mode names agree;
- the lower path contains nine points with a 30 mm lead-in;
- the upper path contains eight points and begins at the lower boundary entry;
- the derived strand is 0.8 × 0.4 mm;
- the 3 × 3, 6 mm-span outside dimensions are 21.2 × 21.2 mm;
- total direct-contact stack height is 0.8 mm.

## Runtime acceptance still required

OpenSCAD was not installed in the packaging environment. The user acceptance
sequence remains:

1. open `main.scad`;
2. press F5 and confirm both validation PASS messages;
3. press F6;
4. export STL;
5. inspect slicer extrusion order;
6. print the coupon.
