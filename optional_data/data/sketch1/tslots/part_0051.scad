$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 30 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 10], [53, 10], [53, 5], [43, 5], [43, 25], [53, 25], [53, 20], [60, 20], [60, 30], [0, 30], [0, 20], [7, 20], [7, 25], [17, 25], [17, 5], [7, 5], [7, 10], [0, 10]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
