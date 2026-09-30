$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 11], [44, 11], [44, 6], [30, 6], [30, 30], [44, 30], [44, 25], [50, 25], [50, 36], [0, 36], [0, 25], [6, 25], [6, 30], [20, 30], [20, 6], [6, 6], [6, 11], [0, 11]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
