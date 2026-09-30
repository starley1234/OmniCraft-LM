$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 36 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 13], [35, 13], [35, 9], [25, 9], [25, 27], [35, 27], [35, 23], [40, 23], [40, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
