$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 12 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [61.373, 0.69], [65, 1.461], [67.481, 4.217], [67.869, 7.905], [66.015, 11.116], [62.627, 12.625], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
