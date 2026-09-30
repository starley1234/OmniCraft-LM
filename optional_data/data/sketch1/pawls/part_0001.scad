$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 14 mm body, beak 7 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [27, 0], [29.121, 0.879], [30, 3], [30, 11], [29.121, 13.121], [27, 14], [24, 14], [15, 21], [6, 14], [3, 14], [0.879, 13.121], [0, 11]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
