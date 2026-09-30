$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[30, 0], [29.708, 4.175], [28.838, 8.269], [24.993, 7.167], [23.254, 11.63], [20.725, 15.699], [17.494, 19.235], [13.668, 22.118], [9.378, 24.25], [4.77, 25.559], [0, 26], [0, 14], [4.326, 13.315], [8.229, 11.326], [11.326, 8.229], [13.315, 4.326], [14, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
