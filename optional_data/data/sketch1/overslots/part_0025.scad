$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 60], [87, 60], [87, 55], [92, 55], [92, 30], [68, 30], [68, 55], [73, 55], [73, 60], [47, 60], [47, 55], [52, 55], [52, 30], [28, 30], [28, 55], [33, 55], [33, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
