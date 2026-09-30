$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 10 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [111.523, 1.685], [114.346, 2.942], [115.891, 5.618], [115.568, 8.691], [113.5, 10.988], [110.477, 11.63], [9.163, 13.315], [4.837, 13.315], [1.337, 10.772]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
