$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 26 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [26, 0], [28.828, 1.172], [30, 4], [30, 22], [28.828, 24.828], [26, 26], [24, 26], [15, 37], [6, 26], [4, 26], [1.172, 24.828], [0, 22]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
