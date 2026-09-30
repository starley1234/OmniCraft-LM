$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 50 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 13], [45, 13], [45, 8], [29, 8], [29, 28], [45, 28], [45, 23], [50, 23], [50, 36], [0, 36], [0, 23], [5, 23], [5, 28], [21, 28], [21, 8], [5, 8], [5, 13], [0, 13]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
