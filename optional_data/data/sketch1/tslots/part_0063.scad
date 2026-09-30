$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 42 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 15], [35, 15], [35, 11], [25, 11], [25, 31], [35, 31], [35, 27], [40, 27], [40, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
