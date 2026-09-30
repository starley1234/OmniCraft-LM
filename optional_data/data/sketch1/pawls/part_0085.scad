$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 14 mm body, beak 7 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [34, 0], [36.828, 1.172], [38, 4], [38, 5], [45, 7], [38, 9], [38, 10], [36.828, 12.828], [34, 14], [4, 14], [1.172, 12.828], [0, 10]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
