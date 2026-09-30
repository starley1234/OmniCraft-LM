$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 7], [33, 7], [33, 4], [23, 4], [23, 26], [33, 26], [33, 23], [40, 23], [40, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
