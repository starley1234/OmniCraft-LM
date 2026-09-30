$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[54.455, 23.955], [58.845, 31.515], [51.734, 41.53], [50.238, 50.144], [38.353, 53.245], [31.669, 58.881], [20.572, 53.618], [11.829, 53.639], [6.711, 42.473], [0, 36.87], [3.257, 25.027], [1.717, 16.421], [11.825, 9.442], [16.177, 1.86], [28.406, 3.01], [36.614, 0], [45.242, 8.742], [53.465, 11.712]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
