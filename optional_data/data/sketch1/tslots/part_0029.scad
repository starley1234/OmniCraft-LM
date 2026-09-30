$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 15], [74, 15], [74, 12], [56, 12], [56, 30], [74, 30], [74, 27], [80, 27], [80, 42], [0, 42], [0, 27], [6, 27], [6, 30], [24, 30], [24, 12], [6, 12], [6, 15], [0, 15]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
