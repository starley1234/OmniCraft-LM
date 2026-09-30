$fn = 32;

// ----------------------------------------------------------------------
// Key bar: woodruff key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[28, 0], [27.523, 3.623], [26.124, 7], [23.899, 9.899], [21, 12.124], [17.623, 13.523], [14, 14], [10.377, 13.523], [7, 12.124], [4.101, 9.899], [1.876, 7], [0.477, 3.623], [0, 0]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
