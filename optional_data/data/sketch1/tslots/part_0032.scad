$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 5], [54, 5], [54, 3], [40, 3], [40, 21], [54, 21], [54, 19], [60, 19], [60, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
