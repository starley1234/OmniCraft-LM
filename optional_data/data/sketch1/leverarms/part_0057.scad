$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 10 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.706], [1.146, 2.18], [4.146, 0], [7.854, 0], [78.523, 0.734], [81.346, 1.991], [82.891, 4.667], [82.568, 7.74], [80.5, 10.036], [77.477, 10.679], [7.854, 11.413], [4.146, 11.413], [1.146, 9.233]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
