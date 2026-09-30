$fn = 32;

// ----------------------------------------------------------------------
// Key bar: woodruff key, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[24, 0], [23.591, 3.106], [22.392, 6], [20.485, 8.485], [18, 10.392], [15.106, 11.591], [12, 12], [8.894, 11.591], [6, 10.392], [3.515, 8.485], [1.608, 6], [0.409, 3.106], [0, 0]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
