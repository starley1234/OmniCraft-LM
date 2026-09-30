$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 22 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [25, 0], [28.536, 1.464], [30, 5], [30, 17], [28.536, 20.536], [25, 22], [24, 22], [15, 33], [6, 22], [5, 22], [1.464, 20.536], [0, 17]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
