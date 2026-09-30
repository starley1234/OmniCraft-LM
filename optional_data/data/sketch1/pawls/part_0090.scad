$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 14 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [51, 0], [53.121, 0.879], [54, 3], [54, 11], [53.121, 13.121], [51, 14], [36, 14], [27, 25], [18, 14], [3, 14], [0.879, 13.121], [0, 11]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
