$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[43.451, 21.958], [51.769, 28.331], [41.083, 35.529], [42.458, 45.918], [29.811, 43.451], [23.438, 51.769], [16.24, 41.083], [5.851, 42.458], [8.318, 29.811], [0, 23.438], [10.687, 16.24], [9.312, 5.851], [21.958, 8.318], [28.331, 0], [35.529, 10.687], [45.918, 9.312]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
