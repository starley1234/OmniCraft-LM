$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 10 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.706], [1.146, 2.18], [4.146, 0], [7.854, 0], [50.477, 0.734], [53.5, 1.376], [55.568, 3.673], [55.891, 6.746], [54.346, 9.422], [51.523, 10.679], [7.854, 11.413], [4.146, 11.413], [1.146, 9.233]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
