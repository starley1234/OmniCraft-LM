$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 22 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 18], [44.828, 20.828], [42, 22], [32, 22], [23, 33], [14, 22], [4, 22], [1.172, 20.828], [0, 18]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
