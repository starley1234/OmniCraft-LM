$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 170 mm bar, pitch 26.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [170, 0], [170, 10], [153.333, 10], [152.333, 15], [149.333, 15], [148.333, 10], [127, 10], [126, 15], [123, 15], [122, 10], [100.667, 10], [99.667, 15], [96.667, 15], [95.667, 10], [74.333, 10], [73.333, 15], [70.333, 15], [69.333, 10], [48, 10], [47, 15], [44, 15], [43, 10], [21.667, 10], [20.667, 15], [17.667, 15], [16.667, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
