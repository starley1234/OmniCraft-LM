$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 170 mm bar, pitch 25.67 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [170, 0], [170, 8], [151.167, 8], [150.367, 19], [147.967, 19], [147.167, 8], [125.5, 8], [124.7, 19], [122.3, 19], [121.5, 8], [99.833, 8], [99.033, 19], [96.633, 19], [95.833, 8], [74.167, 8], [73.367, 19], [70.967, 19], [70.167, 8], [48.5, 8], [47.7, 19], [45.3, 19], [44.5, 8], [22.833, 8], [22.033, 19], [19.633, 19], [18.833, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
