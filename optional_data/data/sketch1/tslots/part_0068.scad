$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 14], [45, 14], [45, 10], [35, 10], [35, 32], [45, 32], [45, 28], [50, 28], [50, 42], [0, 42], [0, 28], [5, 28], [5, 32], [15, 32], [15, 10], [5, 10], [5, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
