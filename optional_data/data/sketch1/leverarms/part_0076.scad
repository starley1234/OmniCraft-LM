$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 12 mm, 35 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [41.373, 0.69], [63.523, 1.685], [66.346, 2.942], [67.891, 5.618], [67.568, 8.691], [65.5, 10.988], [62.477, 11.63], [42.627, 12.625], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
