$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 42 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 14], [43, 14], [43, 9], [29, 9], [29, 33], [43, 33], [43, 28], [50, 28], [50, 42], [0, 42], [0, 28], [7, 28], [7, 33], [21, 33], [21, 9], [7, 9], [7, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
