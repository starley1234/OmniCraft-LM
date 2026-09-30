$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 7], [64, 7], [64, 3], [46, 3], [46, 21], [64, 21], [64, 17], [70, 17], [70, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
