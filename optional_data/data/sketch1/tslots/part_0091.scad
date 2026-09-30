$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 36 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 12], [44, 12], [44, 9], [30, 9], [30, 27], [44, 27], [44, 24], [50, 24], [50, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
