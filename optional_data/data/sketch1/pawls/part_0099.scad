$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 14 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 10], [44.828, 12.828], [42, 14], [28, 14], [23, 23], [18, 14], [4, 14], [1.172, 12.828], [0, 10]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
