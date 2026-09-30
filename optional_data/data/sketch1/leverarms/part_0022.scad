$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 8 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [77.523, 0], [80.346, 1.257], [81.891, 3.933], [81.568, 7.006], [79.5, 9.303], [76.477, 9.945], [3.455, 9.728], [0.955, 7.912]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
