$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[44, 0], [43.192, 8.396], [40.796, 16.483], [37.087, 14.984], [34.027, 21.027], [29.991, 26.467], [25.095, 31.149], [19.48, 34.936], [13.305, 37.722], [6.749, 39.426], [0, 40], [0, 28], [8.652, 26.63], [16.458, 22.652], [22.652, 16.458], [26.63, 8.652], [28, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
