$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 8], [64, 8], [64, 4], [46, 4], [46, 26], [64, 26], [64, 22], [70, 22], [70, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
