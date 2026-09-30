$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 5], [65, 5], [65, 3], [51, 3], [51, 21], [65, 21], [65, 19], [70, 19], [70, 24], [0, 24], [0, 19], [5, 19], [5, 21], [19, 21], [19, 3], [5, 3], [5, 5], [0, 5]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
