$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 30 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 8], [74, 8], [74, 3], [64, 3], [64, 27], [74, 27], [74, 22], [80, 22], [80, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
