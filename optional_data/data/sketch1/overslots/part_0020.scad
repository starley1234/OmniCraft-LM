$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 40], [114.5, 40], [114.5, 35], [117.5, 35], [117.5, 10], [82.5, 10], [82.5, 35], [85.5, 35], [85.5, 40], [64.5, 40], [64.5, 35], [67.5, 35], [67.5, 10], [32.5, 10], [32.5, 35], [35.5, 35], [35.5, 40], [0, 40]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
