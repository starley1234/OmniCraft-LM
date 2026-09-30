$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 26 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [50, 0], [52.828, 1.172], [54, 4], [54, 22], [52.828, 24.828], [50, 26], [36, 26], [27, 37], [18, 26], [4, 26], [1.172, 24.828], [0, 22]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
