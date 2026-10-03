$fn = 32;
// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 14 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 11], [45.121, 13.121], [43, 14], [32, 14], [23, 25], [14, 14], [3, 14], [0.879, 13.121], [0, 11]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
