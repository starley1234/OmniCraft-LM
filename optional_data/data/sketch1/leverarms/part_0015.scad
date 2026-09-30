$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 10 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [79.477, 0], [82.5, 0.642], [84.568, 2.939], [84.891, 6.012], [83.346, 8.688], [7.5, 69.303], [4.477, 69.945], [1.654, 68.688], [0.109, 66.012]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
