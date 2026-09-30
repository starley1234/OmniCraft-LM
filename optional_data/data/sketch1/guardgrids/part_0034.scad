$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 180 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 70], [170, 70], [170, 12], [167, 12], [167, 64], [160, 64], [160, 12], [130.25, 12], [130.25, 64], [123.25, 64], [123.25, 12], [93.5, 12], [93.5, 64], [86.5, 64], [86.5, 12], [56.75, 12], [56.75, 64], [49.75, 64], [49.75, 12], [20, 12], [20, 64], [13, 64], [13, 12], [10, 12], [10, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
