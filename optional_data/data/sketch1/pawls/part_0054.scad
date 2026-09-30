$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 22 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [49, 0], [52.536, 1.464], [54, 5], [54, 17], [52.536, 20.536], [49, 22], [36, 22], [27, 33], [18, 22], [5, 22], [1.464, 20.536], [0, 17]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
