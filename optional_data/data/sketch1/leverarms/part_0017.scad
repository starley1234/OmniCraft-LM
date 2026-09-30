$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 10 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [49.477, 0], [52.5, 0.642], [54.568, 2.939], [54.891, 6.012], [53.346, 8.688], [50.523, 9.945], [3.455, 9.728], [0.955, 7.912]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
