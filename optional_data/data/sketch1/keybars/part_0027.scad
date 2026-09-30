$fn = 32;

// ----------------------------------------------------------------------
// Key bar: hex key, 60 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 6;       // points of the closed outline

profile = [[14.664, 6.35], [10.998, 12.699], [3.666, 12.699], [0, 6.35], [3.666, 0], [10.998, 0]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
