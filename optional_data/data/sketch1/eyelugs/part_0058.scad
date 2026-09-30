$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 24], [44.828, 26.828], [42, 28], [33, 28], [30.172, 26.828], [29, 24], [29, 14], [27.828, 11.172], [25, 10], [21, 10], [18.172, 11.172], [17, 14], [17, 24], [15.828, 26.828], [13, 28], [4, 28], [1.172, 26.828], [0, 24]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
