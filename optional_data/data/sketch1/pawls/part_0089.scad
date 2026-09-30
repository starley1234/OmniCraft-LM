$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 14 mm body, beak 7 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [26, 0], [28.828, 1.172], [30, 4], [30, 5], [37, 7], [30, 9], [30, 10], [28.828, 12.828], [26, 14], [4, 14], [1.172, 12.828], [0, 10]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
