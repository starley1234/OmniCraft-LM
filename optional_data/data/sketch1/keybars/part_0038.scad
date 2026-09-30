$fn = 32;

// ----------------------------------------------------------------------
// Key bar: hex key, 30 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 30;      // extrusion height
profile_points = 6;       // points of the closed outline

profile = [[9.168, 3.97], [6.876, 7.94], [2.292, 7.94], [0, 3.97], [2.292, 0], [6.876, 0]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
