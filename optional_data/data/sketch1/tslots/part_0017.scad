$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 7], [54, 7], [54, 3], [44, 3], [44, 21], [54, 21], [54, 17], [60, 17], [60, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
