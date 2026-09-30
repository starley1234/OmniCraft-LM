$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 18 mm body, beak 11 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [34, 0], [36.828, 1.172], [38, 4], [38, 5], [49, 9], [38, 13], [38, 14], [36.828, 16.828], [34, 18], [4, 18], [1.172, 16.828], [0, 14]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
