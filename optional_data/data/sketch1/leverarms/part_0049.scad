$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 12 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 5.967], [1.146, 2.44], [4.146, 0.261], [50.373, 0], [78.523, 0.995], [81.346, 2.251], [82.891, 4.928], [82.568, 8.001], [80.5, 10.297], [77.477, 10.94], [51.627, 11.934], [4.146, 11.673], [1.146, 9.494]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
