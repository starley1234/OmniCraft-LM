$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 8 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [52.582, 3.63], [55, 4.144], [56.654, 5.982], [56.913, 8.44], [55.677, 10.581], [10, 47.073], [7.582, 47.587], [5.323, 46.581], [4.087, 44.44]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
