$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 3.978], [0.764, 1.627], [2.764, 0.174], [50.582, 0], [53, 0.514], [54.654, 2.351], [54.913, 4.81], [53.677, 6.951], [51.418, 7.956], [2.764, 7.782], [0.764, 6.329]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
