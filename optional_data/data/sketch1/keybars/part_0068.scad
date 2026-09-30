$fn = 32;

// ----------------------------------------------------------------------
// Key bar: hex key, 30 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 30;      // extrusion height
profile_points = 6;       // points of the closed outline

profile = [[7.332, 3.175], [5.499, 6.35], [1.833, 6.35], [0, 3.175], [1.833, 0], [5.499, 0]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
