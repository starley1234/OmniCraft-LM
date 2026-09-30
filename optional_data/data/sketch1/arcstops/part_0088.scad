$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[24, 0], [23.766, 3.34], [23.07, 6.615], [19.225, 5.513], [17.888, 8.946], [15.943, 12.076], [13.457, 14.796], [10.514, 17.014], [7.214, 18.654], [3.669, 19.661], [0, 20], [0, 12], [3.708, 11.413], [7.053, 9.708], [9.708, 7.053], [11.413, 3.708], [12, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
