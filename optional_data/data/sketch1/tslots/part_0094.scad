$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 6], [55, 6], [55, 3], [41, 3], [41, 21], [55, 21], [55, 18], [60, 18], [60, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
