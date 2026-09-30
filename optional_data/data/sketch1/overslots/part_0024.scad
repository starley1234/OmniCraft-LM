$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 60], [88, 60], [88, 57], [92, 57], [92, 34], [68, 34], [68, 57], [72, 57], [72, 60], [48, 60], [48, 57], [52, 57], [52, 34], [28, 34], [28, 57], [32, 57], [32, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
