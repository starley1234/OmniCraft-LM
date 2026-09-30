$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 30 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 10], [43, 10], [43, 7], [33, 7], [33, 23], [43, 23], [43, 20], [50, 20], [50, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
