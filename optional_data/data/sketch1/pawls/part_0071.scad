$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 14 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [33, 0], [36.536, 1.464], [38, 5], [38, 9], [36.536, 12.536], [33, 14], [28, 14], [19, 23], [10, 14], [5, 14], [1.464, 12.536], [0, 9]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
