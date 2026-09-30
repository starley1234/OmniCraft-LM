$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 18 mm body, beak 9 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [41, 0], [44.536, 1.464], [46, 5], [46, 13], [44.536, 16.536], [41, 18], [32, 18], [23, 27], [14, 18], [5, 18], [1.464, 16.536], [0, 13]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
