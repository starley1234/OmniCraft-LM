$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 10 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [59.477, 0], [93.418, 0.995], [95.677, 2], [96.913, 4.141], [96.654, 6.6], [95, 8.437], [92.582, 8.951], [60.523, 9.945], [3.455, 9.728], [0.955, 7.912]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
