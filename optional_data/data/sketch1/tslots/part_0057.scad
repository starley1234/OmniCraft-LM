$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 7], [35, 7], [35, 3], [24, 3], [24, 21], [35, 21], [35, 17], [40, 17], [40, 24], [0, 24], [0, 17], [5, 17], [5, 21], [16, 21], [16, 3], [5, 3], [5, 7], [0, 7]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
