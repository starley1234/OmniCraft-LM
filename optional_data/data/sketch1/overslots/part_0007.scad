$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [122.5, 60], [122.5, 55], [127.5, 55], [127.5, 30], [97.5, 30], [97.5, 55], [102.5, 55], [102.5, 60], [85, 60], [85, 55], [90, 55], [90, 30], [60, 30], [60, 55], [65, 55], [65, 60], [47.5, 60], [47.5, 55], [52.5, 55], [52.5, 30], [22.5, 30], [22.5, 55], [27.5, 55], [27.5, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
