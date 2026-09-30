$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 4], [35, 4], [35, 3], [21, 3], [21, 21], [35, 21], [35, 20], [40, 20], [40, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
