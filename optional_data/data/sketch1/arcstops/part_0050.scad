$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[50.945, 0], [50.555, 5.567], [49.395, 11.025], [41.705, 8.82], [38.816, 15.723], [34.402, 21.766], [28.706, 26.618], [22.039, 30.015], [14.765, 31.771], [7.283, 31.79], [0, 30.07], [2.052, 24.432], [11.852, 25.984], [21.52, 23.752], [29.647, 18.061], [35.051, 9.74], [36.945, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
