$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [123.5, 60], [123.5, 55], [127.5, 55], [127.5, 34], [97.5, 34], [97.5, 55], [101.5, 55], [101.5, 60], [86, 60], [86, 55], [90, 55], [90, 34], [60, 34], [60, 55], [64, 55], [64, 60], [48.5, 60], [48.5, 55], [52.5, 55], [52.5, 34], [22.5, 34], [22.5, 55], [26.5, 55], [26.5, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
