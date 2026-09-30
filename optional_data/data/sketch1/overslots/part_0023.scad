$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 50], [88, 50], [88, 47], [92, 47], [92, 20], [68, 20], [68, 47], [72, 47], [72, 50], [48, 50], [48, 47], [52, 47], [52, 20], [28, 20], [28, 47], [32, 47], [32, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
