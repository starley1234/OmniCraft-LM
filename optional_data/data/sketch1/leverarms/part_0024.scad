$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 14 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [52.268, 0.647], [56.5, 1.546], [59.395, 4.761], [59.847, 9.064], [57.684, 12.81], [11.5, 49.671], [7.268, 50.57], [3.316, 48.81], [1.153, 45.064]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
