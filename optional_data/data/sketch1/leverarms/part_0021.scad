$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 8 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.706], [1.146, 2.18], [4.146, 0], [7.854, 0], [40.582, 1.728], [43, 2.242], [44.654, 4.079], [44.913, 6.538], [43.677, 8.679], [41.418, 9.684], [7.854, 11.413], [4.146, 11.413], [1.146, 9.233]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
