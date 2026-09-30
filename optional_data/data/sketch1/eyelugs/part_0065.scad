$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 30], [44.828, 32.828], [42, 34], [34, 34], [31.172, 32.828], [30, 30], [30, 16], [28.828, 13.172], [26, 12], [20, 12], [17.172, 13.172], [16, 16], [16, 30], [14.828, 32.828], [12, 34], [4, 34], [1.172, 32.828], [0, 30]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
