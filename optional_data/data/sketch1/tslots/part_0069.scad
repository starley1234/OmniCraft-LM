$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 24 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 7], [43, 7], [43, 4], [29, 4], [29, 20], [43, 20], [43, 17], [50, 17], [50, 24], [0, 24], [0, 17], [7, 17], [7, 20], [21, 20], [21, 4], [7, 4], [7, 7], [0, 7]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
