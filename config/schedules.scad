LAYER_SCHEDULES = [
    layer_schedule(
        name = "X4_Y5_X6_Y5_X4",
        groups = [
            layer_group(0, 4, "OUTER2_SQUARE_INNER_HEX", 1, "Four X-oriented layers"),
            layer_group(90, 5, "OUTER2_SQUARE_INNER_HEX", 1, "Five Y-oriented layers"),
            layer_group(0, 6, "OUTER2_SQUARE_INNER_HEX", 1, "Six X-oriented center layers"),
            layer_group(90, 5, "OUTER2_SQUARE_INNER_HEX", 1, "Five Y-oriented layers"),
            layer_group(0, 4, "OUTER2_SQUARE_INNER_HEX", 1, "Four X-oriented layers")
        ],
        require_symmetry = true,
        notes = "Symmetric 4-5-6-5-4 layer schedule supplied for the tutorial."
    )
];
