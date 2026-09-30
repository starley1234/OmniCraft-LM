$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 26 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [35, 0], [37.121, 0.879], [38, 3], [38, 23], [37.121, 25.121], [35, 26], [28, 26], [19, 35], [10, 26], [3, 26], [0.879, 25.121], [0, 23]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
