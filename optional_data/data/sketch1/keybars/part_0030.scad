$fn = 32;

// ----------------------------------------------------------------------
// Key bar: hex key, 30 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 30;      // extrusion height
profile_points = 6;       // points of the closed outline

profile = [[18.336, 7.94], [13.752, 15.879], [4.584, 15.879], [0, 7.94], [4.584, 0], [13.752, 0]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
