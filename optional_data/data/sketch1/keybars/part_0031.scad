$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 3.978], [0.764, 1.627], [2.764, 0.174], [65.582, 0], [68, 0.514], [69.654, 2.351], [69.913, 4.81], [68.677, 6.951], [66.418, 7.956], [2.764, 7.782], [0.764, 6.329]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
