$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 4.973], [0.955, 2.034], [3.455, 0.217], [79.477, 0], [82.5, 0.642], [84.568, 2.939], [84.891, 6.012], [83.346, 8.688], [80.523, 9.945], [3.455, 9.728], [0.955, 7.912]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
