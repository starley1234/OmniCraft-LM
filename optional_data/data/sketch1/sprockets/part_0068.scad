$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[57.232, 26.186], [63.716, 34.869], [53.811, 45.789], [52.256, 56.514], [37.53, 57.232], [28.847, 63.716], [17.926, 53.811], [7.202, 52.256], [6.484, 37.53], [0, 28.847], [9.905, 17.926], [11.46, 7.202], [26.186, 6.484], [34.869, 0], [45.789, 9.905], [56.514, 11.46]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
