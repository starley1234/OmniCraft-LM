$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [36, 0], [38.828, 1.172], [40, 4], [40, 30], [38.828, 32.828], [36, 34], [32, 34], [29.172, 32.828], [28, 30], [28, 18], [26.828, 15.172], [24, 14], [16, 14], [13.172, 15.172], [12, 18], [12, 30], [10.828, 32.828], [8, 34], [4, 34], [1.172, 32.828], [0, 30]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
