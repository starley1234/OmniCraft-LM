$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 14], [55, 14], [55, 10], [45, 10], [45, 32], [55, 32], [55, 28], [60, 28], [60, 42], [0, 42], [0, 28], [5, 28], [5, 32], [15, 32], [15, 10], [5, 10], [5, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
