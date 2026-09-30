$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[33.405, 16.122], [39.391, 22.177], [31.94, 25.586], [32.634, 34.072], [24.734, 31.894], [19.811, 38.841], [15.16, 32.094], [6.923, 34.251], [7.696, 26.094], [0, 22.452], [5.836, 16.699], [2.282, 8.962], [10.45, 8.307], [12.7, 0.096], [19.378, 4.844], [26.38, 0], [28.444, 7.93], [36.922, 8.72]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
