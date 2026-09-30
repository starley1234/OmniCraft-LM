$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 14], [65, 14], [65, 11], [55, 11], [55, 31], [65, 31], [65, 28], [70, 28], [70, 42], [0, 42], [0, 28], [5, 28], [5, 31], [15, 31], [15, 11], [5, 11], [5, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
