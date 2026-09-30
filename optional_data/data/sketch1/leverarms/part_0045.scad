$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 10 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.706], [1.146, 2.18], [4.146, 0], [7.854, 0], [80.477, 0.734], [83.5, 1.376], [85.568, 3.673], [85.891, 6.746], [84.346, 9.422], [81.523, 10.679], [7.854, 11.413], [4.146, 11.413], [1.146, 9.233]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
