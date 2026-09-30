$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 13], [33, 13], [33, 8], [19, 8], [19, 28], [33, 28], [33, 23], [40, 23], [40, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
