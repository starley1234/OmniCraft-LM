$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 14 mm body, beak 5 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [35, 0], [37.121, 0.879], [38, 3], [38, 11], [37.121, 13.121], [35, 14], [24, 14], [19, 19], [14, 14], [3, 14], [0.879, 13.121], [0, 11]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
