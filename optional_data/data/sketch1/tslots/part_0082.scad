$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 13], [45, 13], [45, 8], [27, 8], [27, 28], [45, 28], [45, 23], [50, 23], [50, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
