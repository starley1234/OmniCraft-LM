$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 6], [65, 6], [65, 3], [51, 3], [51, 21], [65, 21], [65, 18], [70, 18], [70, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
