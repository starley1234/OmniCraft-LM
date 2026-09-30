$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [30, 0], [32.828, 1.172], [34, 4], [34, 18], [32.828, 20.828], [30, 22], [29, 22], [26.172, 20.828], [25, 18], [25, 12], [23.828, 9.172], [21, 8], [13, 8], [10.172, 9.172], [9, 12], [9, 18], [7.828, 20.828], [5, 22], [4, 22], [1.172, 20.828], [0, 18]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
