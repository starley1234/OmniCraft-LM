$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 10 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [39.477, 0], [61.523, 0], [64.346, 1.257], [65.891, 3.933], [65.568, 7.006], [63.5, 9.303], [60.477, 9.945], [40.523, 9.945], [3.455, 9.728], [0.955, 7.912]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
