$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 14], [75, 14], [75, 9], [65, 9], [65, 33], [75, 33], [75, 28], [80, 28], [80, 42], [0, 42], [0, 28], [5, 28], [5, 33], [15, 33], [15, 9], [5, 9], [5, 14], [0, 14]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
