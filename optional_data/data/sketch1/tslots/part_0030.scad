$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 15], [64, 15], [64, 11], [54, 11], [54, 31], [64, 31], [64, 27], [70, 27], [70, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
