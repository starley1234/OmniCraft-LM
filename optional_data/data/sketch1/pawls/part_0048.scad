$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 14 mm body, beak 11 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [41, 0], [44.536, 1.464], [46, 5], [46, 9], [44.536, 12.536], [41, 14], [30, 14], [23, 25], [16, 14], [5, 14], [1.464, 12.536], [0, 9]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
