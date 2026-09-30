$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 36 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 12], [55, 12], [55, 9], [45, 9], [45, 27], [55, 27], [55, 24], [60, 24], [60, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
