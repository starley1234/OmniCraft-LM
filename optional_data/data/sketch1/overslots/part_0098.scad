$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [113.5, 60], [113.5, 57], [117.5, 57], [117.5, 34], [82.5, 34], [82.5, 57], [86.5, 57], [86.5, 60], [63.5, 60], [63.5, 57], [67.5, 57], [67.5, 34], [32.5, 34], [32.5, 57], [36.5, 57], [36.5, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
