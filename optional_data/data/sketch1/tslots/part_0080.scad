$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 24 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 4], [44, 4], [44, 3], [29, 3], [29, 21], [44, 21], [44, 20], [50, 20], [50, 24], [0, 24], [0, 20], [6, 20], [6, 21], [21, 21], [21, 3], [6, 3], [6, 4], [0, 4]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
