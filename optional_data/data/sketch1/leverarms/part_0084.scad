$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 14 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [42.268, 0.647], [46.5, 1.546], [49.395, 4.761], [49.847, 9.064], [47.684, 12.81], [11.5, 34.671], [7.268, 35.57], [3.316, 33.81], [1.153, 30.064]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
