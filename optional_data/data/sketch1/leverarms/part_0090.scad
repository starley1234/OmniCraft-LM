$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 8 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [41.582, 2.679], [44, 3.193], [45.654, 5.03], [45.913, 7.489], [44.677, 9.63], [9, 31.121], [6.582, 31.635], [4.323, 30.63], [3.087, 28.489]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
