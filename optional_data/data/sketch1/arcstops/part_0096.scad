$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46.945, 0], [46.283, 6.869], [44.323, 13.486], [40.615, 11.987], [37.294, 18.158], [32.71, 23.458], [27.083, 27.633], [20.681, 30.483], [13.813, 31.871], [6.807, 31.731], [0, 30.07], [2.052, 24.432], [11.852, 25.984], [21.52, 23.752], [29.647, 18.061], [35.051, 9.74], [36.945, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
