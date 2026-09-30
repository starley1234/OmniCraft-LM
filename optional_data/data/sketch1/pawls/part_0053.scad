$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 38 x 18 mm body, beak 5 mm сверху
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [33, 0], [36.536, 1.464], [38, 5], [38, 13], [36.536, 16.536], [33, 18], [28, 18], [19, 23], [10, 18], [5, 18], [1.464, 16.536], [0, 13]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
