$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 22 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 19], [45.121, 21.121], [43, 22], [32, 22], [23, 33], [14, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
