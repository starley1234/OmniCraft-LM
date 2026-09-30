$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 12 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.967], [0.955, 3.028], [3.455, 1.212], [59.373, 0], [93.418, 1.989], [95.677, 2.995], [96.913, 5.135], [96.654, 7.594], [95, 9.431], [92.582, 9.945], [60.627, 11.934], [3.455, 10.722], [0.955, 8.906]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
