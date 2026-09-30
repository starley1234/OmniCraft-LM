$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[47.355, 21.085], [51.769, 28.331], [44.46, 37.673], [42.458, 45.918], [30.684, 47.355], [23.438, 51.769], [14.096, 44.46], [5.851, 42.458], [4.414, 30.684], [0, 23.438], [7.309, 14.096], [9.312, 5.851], [21.085, 4.414], [28.331, 0], [37.673, 7.309], [45.918, 9.312]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
