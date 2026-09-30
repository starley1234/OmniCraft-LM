$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[58.315, 27.822], [66.691, 35.717], [55.595, 45.398], [56.936, 56.83], [42.213, 57.112], [35.892, 66.732], [24.432, 57.485], [13.406, 60.791], [10.571, 46.341], [0, 41.786], [7.117, 28.894], [1.946, 18.611], [15.685, 13.309], [18.334, 2.108], [32.266, 6.878], [41.496, 0], [49.102, 12.609], [60.593, 13.273]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
