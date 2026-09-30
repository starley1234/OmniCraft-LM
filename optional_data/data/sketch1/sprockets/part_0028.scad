$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[40.464, 18.971], [45.796, 25.062], [38.096, 32.543], [37.559, 40.62], [26.825, 40.464], [20.733, 45.796], [13.253, 38.096], [5.176, 37.559], [5.331, 26.825], [0, 20.733], [7.7, 13.253], [8.237, 5.176], [18.971, 5.331], [25.062, 0], [32.543, 7.7], [40.62, 8.237]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
