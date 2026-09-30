$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 18 mm body, beak 5 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [51, 0], [53.121, 0.879], [54, 3], [54, 15], [53.121, 17.121], [51, 18], [32, 18], [27, 23], [22, 18], [3, 18], [0.879, 17.121], [0, 15]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
