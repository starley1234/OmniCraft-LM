$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 8 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [127.418, 2.679], [129.677, 3.685], [130.913, 5.826], [130.654, 8.284], [129, 10.121], [126.582, 10.635], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
