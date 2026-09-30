$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 30 x 26 mm body, beak 5 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [27, 0], [29.121, 0.879], [30, 3], [30, 8], [35, 13], [30, 18], [30, 23], [29.121, 25.121], [27, 26], [3, 26], [0.879, 25.121], [0, 23]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
