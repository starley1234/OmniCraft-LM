$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 30 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 10], [35, 10], [35, 6], [25, 6], [25, 24], [35, 24], [35, 20], [40, 20], [40, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
