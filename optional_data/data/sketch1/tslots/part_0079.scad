$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 14], [53, 14], [53, 9], [39, 9], [39, 33], [53, 33], [53, 28], [60, 28], [60, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
