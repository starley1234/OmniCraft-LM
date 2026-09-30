$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46.945, 0], [45.875, 8.709], [42.731, 16.901], [39.199, 15.023], [35.56, 20.447], [30.896, 25.019], [25.401, 28.548], [19.304, 30.889], [12.858, 31.943], [6.333, 31.666], [0, 30.07], [2.052, 24.432], [11.852, 25.984], [21.52, 23.752], [29.647, 18.061], [35.051, 9.74], [36.945, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
