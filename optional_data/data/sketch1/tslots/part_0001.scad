$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 16], [64, 16], [64, 13], [54, 13], [54, 29], [64, 29], [64, 26], [70, 26], [70, 42], [0, 42], [0, 26], [6, 26], [6, 29], [16, 29], [16, 13], [6, 13], [6, 16], [0, 16]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
