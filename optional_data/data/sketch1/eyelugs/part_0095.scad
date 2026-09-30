$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 18], [44.828, 20.828], [42, 22], [32, 22], [29.172, 20.828], [28, 18], [28, 12], [26.828, 9.172], [24, 8], [22, 8], [19.172, 9.172], [18, 12], [18, 18], [16.828, 20.828], [14, 22], [4, 22], [1.172, 20.828], [0, 18]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
