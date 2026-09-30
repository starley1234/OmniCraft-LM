$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 14], [44, 14], [44, 11], [34, 11], [34, 31], [44, 31], [44, 28], [50, 28], [50, 42], [0, 42], [0, 28], [6, 28], [6, 31], [16, 31], [16, 11], [6, 11], [6, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
