$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 30 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 9], [54, 9], [54, 4], [44, 4], [44, 26], [54, 26], [54, 21], [60, 21], [60, 30], [0, 30], [0, 21], [6, 21], [6, 26], [16, 26], [16, 4], [6, 4], [6, 9], [0, 9]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
