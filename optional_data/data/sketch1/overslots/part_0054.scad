$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [112.5, 60], [112.5, 55], [117.5, 55], [117.5, 38], [82.5, 38], [82.5, 55], [87.5, 55], [87.5, 60], [62.5, 60], [62.5, 55], [67.5, 55], [67.5, 38], [32.5, 38], [32.5, 55], [37.5, 55], [37.5, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
