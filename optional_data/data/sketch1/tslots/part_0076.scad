$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 8], [53, 8], [53, 4], [35, 4], [35, 26], [53, 26], [53, 22], [60, 22], [60, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
