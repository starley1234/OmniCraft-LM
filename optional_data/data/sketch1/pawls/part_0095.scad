$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 26 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 23], [45.121, 25.121], [43, 26], [32, 26], [23, 35], [14, 26], [3, 26], [0.879, 25.121], [0, 23]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
