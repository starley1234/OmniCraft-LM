$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 18 mm body, beak 7 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [26, 0], [28.828, 1.172], [30, 4], [30, 14], [28.828, 16.828], [26, 18], [20, 18], [15, 25], [10, 18], [4, 18], [1.172, 16.828], [0, 14]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
