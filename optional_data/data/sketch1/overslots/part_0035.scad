$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [111, 60], [111, 57], [115, 57], [115, 34], [85, 34], [85, 57], [89, 57], [89, 60], [61, 60], [61, 57], [65, 57], [65, 34], [35, 34], [35, 57], [39, 57], [39, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
