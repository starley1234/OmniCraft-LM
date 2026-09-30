$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 8 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.706], [1.146, 2.18], [4.146, 0], [7.854, 0], [50.582, 1.728], [53, 2.242], [54.654, 4.079], [54.913, 6.538], [53.677, 8.679], [8, 45.17], [5.582, 45.684], [3.323, 44.679], [2.087, 42.538]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
