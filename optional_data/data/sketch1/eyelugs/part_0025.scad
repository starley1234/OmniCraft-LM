$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [36, 0], [38.828, 1.172], [40, 4], [40, 36], [38.828, 38.828], [36, 40], [32, 40], [29.172, 38.828], [28, 36], [28, 12], [26.828, 9.172], [24, 8], [16, 8], [13.172, 9.172], [12, 12], [12, 36], [10.828, 38.828], [8, 40], [4, 40], [1.172, 38.828], [0, 36]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
