$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 42 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 15], [35, 15], [35, 10], [25, 10], [25, 32], [35, 32], [35, 27], [40, 27], [40, 42], [0, 42], [0, 27], [5, 27], [5, 32], [15, 32], [15, 10], [5, 10], [5, 15], [0, 15]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
