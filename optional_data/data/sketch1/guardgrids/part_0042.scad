$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 180 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 70], [170, 70], [170, 10], [167, 10], [167, 64], [160, 64], [160, 10], [142.5, 10], [142.5, 64], [135.5, 64], [135.5, 10], [118, 10], [118, 64], [111, 64], [111, 10], [93.5, 10], [93.5, 64], [86.5, 64], [86.5, 10], [69, 10], [69, 64], [62, 64], [62, 10], [44.5, 10], [44.5, 64], [37.5, 64], [37.5, 10], [20, 10], [20, 64], [13, 64], [13, 10], [10, 10], [10, 70], [0, 70]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
