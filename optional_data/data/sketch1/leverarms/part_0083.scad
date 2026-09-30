$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 14 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.962], [0.955, 4.023], [3.455, 2.206], [59.268, 0], [93.523, 1.989], [96.346, 3.246], [97.891, 5.922], [97.568, 8.995], [95.5, 11.292], [92.477, 11.934], [60.732, 13.923], [3.455, 11.717], [0.955, 9.901]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
