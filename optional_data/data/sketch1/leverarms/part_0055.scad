$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 8 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [51.582, 2.679], [54, 3.193], [55.654, 5.03], [55.913, 7.489], [54.677, 9.63], [52.418, 10.635], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
