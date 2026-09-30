$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [30, 0], [32.828, 1.172], [34, 4], [34, 36], [32.828, 38.828], [30, 40], [28, 40], [25.172, 38.828], [24, 36], [24, 12], [22.828, 9.172], [20, 8], [14, 8], [11.172, 9.172], [10, 12], [10, 36], [8.828, 38.828], [6, 40], [4, 40], [1.172, 38.828], [0, 36]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
