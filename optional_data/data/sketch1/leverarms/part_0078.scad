$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 10 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [64.523, 2.636], [67.346, 3.893], [68.891, 6.569], [68.568, 9.642], [66.5, 11.939], [63.477, 12.581], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
