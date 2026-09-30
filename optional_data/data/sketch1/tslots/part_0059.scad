$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 9], [64, 9], [64, 5], [46, 5], [46, 25], [64, 25], [64, 21], [70, 21], [70, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
