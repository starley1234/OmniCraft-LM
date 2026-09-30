$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 22 mm body, beak 5 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [34, 0], [36.828, 1.172], [38, 4], [38, 6], [43, 11], [38, 16], [38, 18], [36.828, 20.828], [34, 22], [4, 22], [1.172, 20.828], [0, 18]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
