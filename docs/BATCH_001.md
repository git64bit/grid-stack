# Batch 001 Acceptance

## Source

Repository: `git64bit/grid-stack`

Starting commit supplied by the project owner: `74cfe25`

## Test

1. Open `main.scad`.
2. Press F5.
3. Confirm the viewport remains blank.
4. Open the OpenSCAD Console.
5. Confirm `GRID STACK VALIDATION: PASS` appears.
6. Confirm the report states 24 deposited layers and a nominal height of 4.8 mm.
7. Confirm the schedule is reported as `4, 5, 6, 5, 4` with orientations `0, 90, 0, 90, 0`.

## Acceptance boundary

Batch 001 does not claim that the square-to-hex transition is solved. It only represents the requested transition in the data model.

## Supersession note

Batch 002 corrects the original material-profile model by separating material, nozzle hardware, and the qualified process environment. Batch 001 remains a historical acceptance record.
