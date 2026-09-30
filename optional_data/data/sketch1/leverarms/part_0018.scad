$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 12 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.967], [1.146, 2.44], [4.146, 0.261], [60.373, 0], [94.627, 0], [98.015, 1.508], [99.869, 4.72], [99.481, 8.408], [97, 11.163], [93.373, 11.934], [61.627, 11.934], [4.146, 11.673], [1.146, 9.494]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
