$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 26 mm body, beak 9 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [34, 0], [36.828, 1.172], [38, 4], [38, 5], [47, 13], [38, 21], [38, 22], [36.828, 24.828], [34, 26], [4, 26], [1.172, 24.828], [0, 22]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
