$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 10 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [42.477, 2.636], [45.5, 3.278], [47.568, 5.575], [47.891, 8.648], [46.346, 11.324], [43.523, 12.581], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
