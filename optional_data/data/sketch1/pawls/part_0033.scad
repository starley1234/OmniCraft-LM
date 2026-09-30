$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 22 mm body, beak 5 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [41, 0], [44.536, 1.464], [46, 5], [46, 17], [44.536, 20.536], [41, 22], [32, 22], [23, 27], [14, 22], [5, 22], [1.464, 20.536], [0, 17]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
