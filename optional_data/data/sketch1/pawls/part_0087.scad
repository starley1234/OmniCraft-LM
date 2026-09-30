$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 26 mm body, beak 7 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 4], [53, 13], [46, 22], [46, 23], [45.121, 25.121], [43, 26], [3, 26], [0.879, 25.121], [0, 23]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
