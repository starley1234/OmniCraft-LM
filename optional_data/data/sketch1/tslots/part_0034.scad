$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 36 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 12], [74, 12], [74, 7], [64, 7], [64, 29], [74, 29], [74, 24], [80, 24], [80, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
