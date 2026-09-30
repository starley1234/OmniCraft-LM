$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 18 mm body, beak 5 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [49, 0], [52.536, 1.464], [54, 5], [54, 13], [52.536, 16.536], [49, 18], [32, 18], [27, 23], [22, 18], [5, 18], [1.464, 16.536], [0, 13]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
