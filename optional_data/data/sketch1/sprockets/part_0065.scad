$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[58.87, 29.766], [67.122, 36.235], [57.034, 44.3], [60.479, 54.204], [47.632, 55.535], [45.175, 65.729], [33.648, 59.902], [26.07, 67.15], [19.522, 56.017], [9.229, 58.017], [9.74, 45.111], [0, 41.228], [7.407, 30.648], [1.312, 22.116], [13.264, 17.219], [12.749, 6.746], [25.451, 9.089], [30.68, 0], [40.099, 8.838], [49.411, 4.019], [52.557, 16.546], [62.997, 17.527]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
