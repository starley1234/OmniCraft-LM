$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 40], [110, 40], [110, 35], [115, 35], [115, 10], [85, 10], [85, 35], [90, 35], [90, 40], [60, 40], [60, 35], [65, 35], [65, 10], [35, 10], [35, 35], [40, 35], [40, 40], [0, 40]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
