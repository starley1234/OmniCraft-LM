$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[28, 0], [27.168, 6.774], [24.723, 13.145], [17.659, 9.389], [16.003, 11.996], [13.965, 14.317], [11.594, 16.297], [8.946, 17.888], [6.085, 19.052], [3.079, 19.762], [0, 20], [0, 12], [3.708, 11.413], [7.053, 9.708], [9.708, 7.053], [11.413, 3.708], [12, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
