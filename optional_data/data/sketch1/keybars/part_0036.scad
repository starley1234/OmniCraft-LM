$fn = 32;

// ----------------------------------------------------------------------
// Key bar: hex key, 30 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 30;      // extrusion height
profile_points = 6;       // points of the closed outline

profile = [[21.998, 9.525], [16.498, 19.051], [5.5, 19.051], [0, 9.525], [5.499, 0], [16.498, 0]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
