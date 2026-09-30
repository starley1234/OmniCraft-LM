$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 26 mm body, beak 7 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [33, 0], [36.536, 1.464], [38, 5], [38, 6], [45, 13], [38, 20], [38, 21], [36.536, 24.536], [33, 26], [5, 26], [1.464, 24.536], [0, 21]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
