$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 10 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [59.477, 0], [62.5, 0.642], [64.568, 2.939], [64.891, 6.012], [63.346, 8.688], [7.5, 42.303], [4.477, 42.945], [1.654, 41.688], [0.109, 39.012]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
