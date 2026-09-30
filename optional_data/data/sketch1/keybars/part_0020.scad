$fn = 32;

// ----------------------------------------------------------------------
// Key bar: hex key, 60 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 6;       // points of the closed outline

profile = [[11.004, 4.765], [8.253, 9.53], [2.751, 9.53], [0, 4.765], [2.751, 0], [8.253, 0]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
