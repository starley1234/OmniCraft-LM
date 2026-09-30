$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 22 mm body, beak 7 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [26, 0], [28.828, 1.172], [30, 4], [30, 5], [37, 11], [30, 17], [30, 18], [28.828, 20.828], [26, 22], [4, 22], [1.172, 20.828], [0, 18]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
