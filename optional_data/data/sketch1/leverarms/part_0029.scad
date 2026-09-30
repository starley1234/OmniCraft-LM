$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 14 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [72.268, 0.647], [76.5, 1.546], [79.395, 4.761], [79.847, 9.064], [77.684, 12.81], [73.732, 14.57], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
