$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 24 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 6], [44, 6], [44, 3], [30, 3], [30, 21], [44, 21], [44, 18], [50, 18], [50, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
