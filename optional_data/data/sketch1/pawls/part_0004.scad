$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 26 mm body, beak 5 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [49, 0], [52.536, 1.464], [54, 5], [54, 21], [52.536, 24.536], [49, 26], [36, 26], [27, 31], [18, 26], [5, 26], [1.464, 24.536], [0, 21]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
