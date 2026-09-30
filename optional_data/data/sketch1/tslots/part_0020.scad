$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 7], [43, 7], [43, 3], [33, 3], [33, 21], [43, 21], [43, 17], [50, 17], [50, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
