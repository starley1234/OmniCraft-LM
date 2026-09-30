$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 170 mm bar, pitch 26.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [170, 0], [170, 14], [152.333, 14], [151.733, 22], [149.933, 22], [149.333, 14], [126, 14], [125.4, 22], [123.6, 22], [123, 14], [99.667, 14], [99.067, 22], [97.267, 22], [96.667, 14], [73.333, 14], [72.733, 22], [70.933, 22], [70.333, 14], [47, 14], [46.4, 22], [44.6, 22], [44, 14], [20.667, 14], [20.067, 22], [18.267, 22], [17.667, 14], [0, 14]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
