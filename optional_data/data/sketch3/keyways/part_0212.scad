$fn = 32;

// ----------------------------------------------------------------------
// Keyway shaft: d32 shaft, key 5 x 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shaft_r = 16;             // shaft radius
key_w = 5;                // keyway width
key_d = 3;                // keyway depth below the surface line
plate_t = 50;             // shaft length, Z (extrusion height)

shaft_d = 2 * shaft_r;  // shaft diameter
circle_step = 15;  // polygon sampling step, degrees

profile = [[11.859, 31.455], [8, 29.856], [4.686, 27.314], [2.144, 24], [0.545, 20.141], [0, 16], [0.545, 11.859], [2.144, 8], [4.686, 4.686], [8, 2.144], [11.859, 0.545], [16, 0], [20.141, 0.545], [24, 2.144], [27.314, 4.686], [29.856, 8], [31.455, 11.859], [32, 16], [31.455, 20.141], [29.856, 24], [27.314, 27.314], [24, 29.856], [20.141, 31.455], [18.5, 31.803], [18.5, 28.803], [13.5, 28.803], [13.5, 31.803]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
