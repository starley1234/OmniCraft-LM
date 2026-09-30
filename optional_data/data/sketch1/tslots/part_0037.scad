$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 42 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 14], [34, 14], [34, 10], [16, 10], [16, 32], [34, 32], [34, 28], [40, 28], [40, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
