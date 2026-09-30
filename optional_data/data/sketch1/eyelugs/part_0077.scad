$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [30, 0], [32.828, 1.172], [34, 4], [34, 24], [32.828, 26.828], [30, 28], [26, 28], [23.172, 26.828], [22, 24], [22, 18], [20.828, 15.172], [18, 14], [16, 14], [13.172, 15.172], [12, 18], [12, 24], [10.828, 26.828], [8, 28], [4, 28], [1.172, 26.828], [0, 24]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
