$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 4], [53, 4], [53, 3], [39, 3], [39, 21], [53, 21], [53, 20], [60, 20], [60, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
