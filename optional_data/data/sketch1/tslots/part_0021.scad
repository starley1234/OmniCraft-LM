$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 9], [73, 9], [73, 5], [63, 5], [63, 25], [73, 25], [73, 21], [80, 21], [80, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
