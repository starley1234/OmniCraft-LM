$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 18 mm body, beak 9 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [41, 0], [44.536, 1.464], [46, 5], [46, 6], [55, 9], [46, 12], [46, 13], [44.536, 16.536], [41, 18], [5, 18], [1.464, 16.536], [0, 13]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
