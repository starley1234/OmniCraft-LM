$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 30], [44.828, 32.828], [42, 34], [35, 34], [32.172, 32.828], [31, 30], [31, 12], [29.828, 9.172], [27, 8], [19, 8], [16.172, 9.172], [15, 12], [15, 30], [13.828, 32.828], [11, 34], [4, 34], [1.172, 32.828], [0, 30]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
