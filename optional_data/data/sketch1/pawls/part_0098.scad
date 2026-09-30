$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 54 x 22 mm body, beak 11 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [51, 0], [53.121, 0.879], [54, 3], [54, 4], [65, 11], [54, 18], [54, 19], [53.121, 21.121], [51, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
