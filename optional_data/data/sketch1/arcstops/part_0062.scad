$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46.712, 0], [45.821, 7.258], [43.201, 14.084], [39.669, 12.206], [35.86, 17.589], [30.819, 21.841], [24.87, 24.687], [18.397, 25.945], [11.815, 25.535], [5.548, 23.481], [0, 19.917], [6.428, 12.257], [12.842, 15.525], [20.039, 15.65], [26.563, 12.608], [31.093, 7.014], [32.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
