$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 22 mm body, beak 5 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [35, 0], [37.121, 0.879], [38, 3], [38, 4], [43, 11], [38, 18], [38, 19], [37.121, 21.121], [35, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
