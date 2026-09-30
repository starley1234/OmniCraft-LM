$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 14 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.962], [1.337, 2.847], [4.837, 0.304], [41.268, 0], [63.523, 1.989], [66.346, 3.246], [67.891, 5.922], [67.568, 8.995], [65.5, 11.292], [62.477, 11.934], [42.732, 13.923], [4.837, 13.619], [1.337, 11.076]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
