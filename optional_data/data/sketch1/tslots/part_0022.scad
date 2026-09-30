$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 30 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 9], [35, 9], [35, 5], [24, 5], [24, 25], [35, 25], [35, 21], [40, 21], [40, 30], [0, 30], [0, 21], [5, 21], [5, 25], [16, 25], [16, 5], [5, 5], [5, 9], [0, 9]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
