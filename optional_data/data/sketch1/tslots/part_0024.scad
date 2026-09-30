$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 36 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 11], [74, 11], [74, 7], [56, 7], [56, 29], [74, 29], [74, 25], [80, 25], [80, 36], [0, 36], [0, 25], [6, 25], [6, 29], [24, 29], [24, 7], [6, 7], [6, 11], [0, 11]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
