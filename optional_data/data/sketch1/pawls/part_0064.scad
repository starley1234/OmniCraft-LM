$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 18 mm body, beak 7 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [27, 0], [29.121, 0.879], [30, 3], [30, 15], [29.121, 17.121], [27, 18], [20, 18], [15, 25], [10, 18], [3, 18], [0.879, 17.121], [0, 15]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
