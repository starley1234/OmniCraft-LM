$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 6], [55, 6], [55, 3], [41, 3], [41, 21], [55, 21], [55, 18], [60, 18], [60, 24], [0, 24], [0, 18], [5, 18], [5, 21], [19, 21], [19, 3], [5, 3], [5, 6], [0, 6]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
