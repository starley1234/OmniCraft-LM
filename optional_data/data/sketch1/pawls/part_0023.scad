$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 22 mm body, beak 7 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [27, 0], [29.121, 0.879], [30, 3], [30, 19], [29.121, 21.121], [27, 22], [22, 22], [15, 29], [8, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
