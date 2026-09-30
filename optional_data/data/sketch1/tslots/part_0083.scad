$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 42 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 16], [54, 16], [54, 13], [40, 13], [40, 29], [54, 29], [54, 26], [60, 26], [60, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
