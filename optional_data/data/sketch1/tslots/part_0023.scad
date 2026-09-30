$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 24 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 5], [64, 5], [64, 3], [54, 3], [54, 21], [64, 21], [64, 19], [70, 19], [70, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
