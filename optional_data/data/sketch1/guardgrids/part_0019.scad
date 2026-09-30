$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [170, 40], [170, 10], [167, 10], [167, 24], [160, 24], [160, 10], [142.5, 10], [142.5, 24], [135.5, 24], [135.5, 10], [118, 10], [118, 24], [111, 24], [111, 10], [93.5, 10], [93.5, 24], [86.5, 24], [86.5, 10], [69, 10], [69, 24], [62, 24], [62, 10], [44.5, 10], [44.5, 24], [37.5, 24], [37.5, 10], [20, 10], [20, 24], [13, 24], [13, 10], [10, 10], [10, 40], [0, 40]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
