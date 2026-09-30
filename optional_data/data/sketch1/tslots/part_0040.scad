$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 36 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 12], [55, 12], [55, 7], [41, 7], [41, 29], [55, 29], [55, 24], [60, 24], [60, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
