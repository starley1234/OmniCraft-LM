$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 36 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 13], [54, 13], [54, 8], [36, 8], [36, 28], [54, 28], [54, 23], [60, 23], [60, 36], [0, 36], [0, 23], [6, 23], [6, 28], [24, 28], [24, 8], [6, 8], [6, 13], [0, 13]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
