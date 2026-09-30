$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 8 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [61.582, 2.679], [64, 3.193], [65.654, 5.03], [65.913, 7.489], [64.677, 9.63], [62.418, 10.635], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
