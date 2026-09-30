$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 14 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [82.268, 0.647], [86.5, 1.546], [89.395, 4.761], [89.847, 9.064], [87.684, 12.81], [11.5, 73.671], [7.268, 74.57], [3.316, 72.81], [1.153, 69.064]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
