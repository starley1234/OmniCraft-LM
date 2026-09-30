$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 10 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [39.477, 0], [42.5, 0.642], [44.568, 2.939], [44.891, 6.012], [43.346, 8.688], [40.523, 9.945], [3.455, 9.728], [0.955, 7.912]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
