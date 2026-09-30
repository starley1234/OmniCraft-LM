$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 18 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 15], [45.121, 17.121], [43, 18], [32, 18], [23, 27], [14, 18], [3, 18], [0.879, 17.121], [0, 15]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
