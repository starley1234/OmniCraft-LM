$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 8 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.706], [1.146, 2.18], [4.146, 0], [7.854, 0], [80.582, 1.728], [83, 2.242], [84.654, 4.079], [84.913, 6.538], [83.677, 8.679], [81.418, 9.684], [7.854, 11.413], [4.146, 11.413], [1.146, 9.233]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
