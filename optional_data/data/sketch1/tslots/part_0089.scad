$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 30 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 9], [45, 9], [45, 5], [35, 5], [35, 25], [45, 25], [45, 21], [50, 21], [50, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
