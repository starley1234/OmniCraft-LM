$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 5], [43, 5], [43, 3], [25, 3], [25, 21], [43, 21], [43, 19], [50, 19], [50, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
