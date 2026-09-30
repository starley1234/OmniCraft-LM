$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 11], [43, 11], [43, 8], [29, 8], [29, 28], [43, 28], [43, 25], [50, 25], [50, 36], [0, 36], [0, 25], [7, 25], [7, 28], [21, 28], [21, 8], [7, 8], [7, 11], [0, 11]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
