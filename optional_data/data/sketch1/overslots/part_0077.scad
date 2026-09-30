$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [114.5, 60], [114.5, 55], [117.5, 55], [117.5, 30], [82.5, 30], [82.5, 55], [85.5, 55], [85.5, 60], [64.5, 60], [64.5, 55], [67.5, 55], [67.5, 30], [32.5, 30], [32.5, 55], [35.5, 55], [35.5, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
