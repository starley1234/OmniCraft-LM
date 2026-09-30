$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 6], [54, 6], [54, 3], [44, 3], [44, 21], [54, 21], [54, 18], [60, 18], [60, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
