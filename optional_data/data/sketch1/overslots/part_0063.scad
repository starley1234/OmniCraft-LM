$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [110, 60], [110, 57], [115, 57], [115, 30], [85, 30], [85, 57], [90, 57], [90, 60], [60, 60], [60, 57], [65, 57], [65, 30], [35, 30], [35, 57], [40, 57], [40, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
