$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 30 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 7], [74, 7], [74, 3], [60, 3], [60, 27], [74, 27], [74, 23], [80, 23], [80, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
