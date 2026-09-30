$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 13], [44, 13], [44, 10], [34, 10], [34, 32], [44, 32], [44, 29], [50, 29], [50, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
