$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 18 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [25, 0], [28.536, 1.464], [30, 5], [30, 13], [28.536, 16.536], [25, 18], [20, 18], [15, 27], [10, 18], [5, 18], [1.464, 16.536], [0, 13]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
