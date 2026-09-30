$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [124.5, 60], [124.5, 55], [127.5, 55], [127.5, 30], [97.5, 30], [97.5, 55], [100.5, 55], [100.5, 60], [87, 60], [87, 55], [90, 55], [90, 30], [60, 30], [60, 55], [63, 55], [63, 60], [49.5, 60], [49.5, 55], [52.5, 55], [52.5, 30], [22.5, 30], [22.5, 55], [25.5, 55], [25.5, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
