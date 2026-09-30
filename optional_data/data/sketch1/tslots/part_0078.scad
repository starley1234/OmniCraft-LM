$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 15], [33, 15], [33, 10], [19, 10], [19, 32], [33, 32], [33, 27], [40, 27], [40, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
