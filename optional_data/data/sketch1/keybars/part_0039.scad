$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 3.978], [0.764, 1.627], [2.764, 0.174], [35.582, 0], [38, 0.514], [39.654, 2.351], [39.913, 4.81], [38.677, 6.951], [36.418, 7.956], [2.764, 7.782], [0.764, 6.329]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
