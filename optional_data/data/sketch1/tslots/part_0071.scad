$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 42 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 14], [73, 14], [73, 10], [55, 10], [55, 32], [73, 32], [73, 28], [80, 28], [80, 42], [0, 42], [0, 28], [7, 28], [7, 32], [25, 32], [25, 10], [7, 10], [7, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
