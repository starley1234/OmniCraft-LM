$fn = 32;

// ----------------------------------------------------------------------
// Flat adaptor: keyed, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 18], [2.412, 9], [9, 2.412], [18, 0], [27, 2.412], [33.588, 9], [36, 18], [33.588, 27], [27, 33.588], [18, 36], [9, 33.588], [2.412, 27]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
