$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 26 mm body, beak 5 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [51, 0], [53.121, 0.879], [54, 3], [54, 4], [59, 13], [54, 22], [54, 23], [53.121, 25.121], [51, 26], [3, 26], [0.879, 25.121], [0, 23]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
