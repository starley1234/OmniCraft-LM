$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[40.159, 18.666], [45.185, 26.902], [37.791, 32.237], [35.521, 41.615], [26.519, 40.159], [18.283, 45.185], [12.948, 37.791], [3.57, 35.521], [5.026, 26.519], [0, 18.283], [7.395, 12.948], [9.665, 3.57], [18.666, 5.026], [26.902, 0], [32.237, 7.395], [41.615, 9.665]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
