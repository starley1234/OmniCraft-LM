$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 14], [44, 14], [44, 10], [34, 10], [34, 32], [44, 32], [44, 28], [50, 28], [50, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
