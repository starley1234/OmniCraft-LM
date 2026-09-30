$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 7], [74, 7], [74, 4], [64, 4], [64, 20], [74, 20], [74, 17], [80, 17], [80, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
