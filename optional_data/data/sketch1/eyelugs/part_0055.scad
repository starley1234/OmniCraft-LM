$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [36, 0], [38.828, 1.172], [40, 4], [40, 30], [38.828, 32.828], [36, 34], [30, 34], [27.172, 32.828], [26, 30], [26, 16], [24.828, 13.172], [22, 12], [18, 12], [15.172, 13.172], [14, 16], [14, 30], [12.828, 32.828], [10, 34], [4, 34], [1.172, 32.828], [0, 30]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
