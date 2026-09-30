$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [36, 0], [38.828, 1.172], [40, 4], [40, 24], [38.828, 26.828], [36, 28], [32, 28], [29.172, 26.828], [28, 24], [28, 12], [26.828, 9.172], [24, 8], [16, 8], [13.172, 9.172], [12, 12], [12, 24], [10.828, 26.828], [8, 28], [4, 28], [1.172, 26.828], [0, 24]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
