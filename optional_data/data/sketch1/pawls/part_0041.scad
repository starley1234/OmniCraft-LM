$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 18 mm body, beak 9 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [42, 0], [44.828, 1.172], [46, 4], [46, 5], [55, 9], [46, 13], [46, 14], [44.828, 16.828], [42, 18], [4, 18], [1.172, 16.828], [0, 14]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
