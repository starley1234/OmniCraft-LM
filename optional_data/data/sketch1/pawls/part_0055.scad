$fn = 32;

// ----------------------------------------------------------------------
// Ratchet pawl: 46 x 26 mm body, beak 9 mm с правого торца
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 5], [1.464, 1.464], [5, 0], [41, 0], [44.536, 1.464], [46, 5], [46, 6], [55, 13], [46, 20], [46, 21], [44.536, 24.536], [41, 26], [5, 26], [1.464, 24.536], [0, 21]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
