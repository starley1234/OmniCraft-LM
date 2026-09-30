$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[34, 0], [33.669, 4.732], [32.683, 9.372], [24.993, 7.167], [23.254, 11.63], [20.725, 15.699], [17.494, 19.235], [13.668, 22.118], [9.378, 24.25], [4.77, 25.559], [0, 26], [0, 20], [6.18, 19.021], [11.756, 16.18], [16.18, 11.756], [19.021, 6.18], [20, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
