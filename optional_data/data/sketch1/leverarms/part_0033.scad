$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 14 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [42.268, 0.647], [64.627, 1.641], [68.015, 3.15], [69.869, 6.361], [69.481, 10.049], [67, 12.805], [63.373, 13.576], [43.732, 14.57], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
