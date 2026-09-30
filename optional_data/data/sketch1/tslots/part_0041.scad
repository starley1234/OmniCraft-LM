$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 4], [55, 4], [55, 3], [37, 3], [37, 21], [55, 21], [55, 20], [60, 20], [60, 24], [0, 24], [0, 20], [5, 20], [5, 21], [23, 21], [23, 3], [5, 3], [5, 4], [0, 4]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
