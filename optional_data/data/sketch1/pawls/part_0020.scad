$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 14 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [50, 0], [52.828, 1.172], [54, 4], [54, 10], [52.828, 12.828], [50, 14], [34, 14], [27, 25], [20, 14], [4, 14], [1.172, 12.828], [0, 10]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
