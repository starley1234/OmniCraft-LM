$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 18 mm body, beak 11 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [50, 0], [52.828, 1.172], [54, 4], [54, 5], [65, 9], [54, 13], [54, 14], [52.828, 16.828], [50, 18], [4, 18], [1.172, 16.828], [0, 14]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
