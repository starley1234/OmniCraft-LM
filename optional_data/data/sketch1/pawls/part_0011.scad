$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 22 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [33, 0], [36.536, 1.464], [38, 5], [38, 17], [36.536, 20.536], [33, 22], [28, 22], [19, 31], [10, 22], [5, 22], [1.464, 20.536], [0, 17]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
