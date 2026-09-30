$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 5], [63, 5], [63, 3], [49, 3], [49, 21], [63, 21], [63, 19], [70, 19], [70, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
