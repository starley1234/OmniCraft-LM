$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 11], [64, 11], [64, 6], [54, 6], [54, 30], [64, 30], [64, 25], [70, 25], [70, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
