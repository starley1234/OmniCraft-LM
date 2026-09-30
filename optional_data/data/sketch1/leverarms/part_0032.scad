$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 10 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [111.627, 0.69], [115.015, 2.199], [116.869, 5.41], [116.481, 9.098], [114, 11.854], [110.373, 12.625], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
