$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [36, 0], [38.828, 1.172], [40, 4], [40, 18], [38.828, 20.828], [36, 22], [29, 22], [26.172, 20.828], [25, 18], [25, 16], [23.828, 13.172], [21, 12], [19, 12], [16.172, 13.172], [15, 16], [15, 18], [13.828, 20.828], [11, 22], [4, 22], [1.172, 20.828], [0, 18]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
