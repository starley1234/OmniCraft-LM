$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 150 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [146, 0], [148.828, 1.172], [150, 4], [150, 60], [116, 60], [116, 57], [120, 57], [120, 30], [80, 30], [80, 57], [84, 57], [84, 60], [66, 60], [66, 57], [70, 57], [70, 30], [30, 30], [30, 57], [34, 57], [34, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
