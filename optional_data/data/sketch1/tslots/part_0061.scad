$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 30 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 7], [53, 7], [53, 4], [39, 4], [39, 26], [53, 26], [53, 23], [60, 23], [60, 30], [0, 30], [0, 23], [7, 23], [7, 26], [21, 26], [21, 4], [7, 4], [7, 7], [0, 7]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
