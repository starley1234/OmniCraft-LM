$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 30 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 8], [54, 8], [54, 5], [44, 5], [44, 25], [54, 25], [54, 22], [60, 22], [60, 30], [0, 30], [0, 22], [6, 22], [6, 25], [16, 25], [16, 5], [6, 5], [6, 8], [0, 8]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
