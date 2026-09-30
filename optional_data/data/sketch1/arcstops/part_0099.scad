$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[27.16, 0], [26.15, 8.225], [23.18, 15.962], [16.116, 12.206], [14.715, 14.539], [13.077, 16.712], [11.221, 18.703], [9.167, 20.488], [6.937, 22.049], [4.557, 23.369], [2.052, 24.432], [0, 18.794], [4.343, 16.581], [8.022, 13.383], [10.819, 9.389], [12.566, 4.838], [13.16, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
