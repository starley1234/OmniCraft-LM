$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 12], [33, 12], [33, 7], [24, 7], [24, 29], [33, 29], [33, 24], [40, 24], [40, 36], [0, 36], [0, 24], [7, 24], [7, 29], [16, 29], [16, 7], [7, 7], [7, 12], [0, 12]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
