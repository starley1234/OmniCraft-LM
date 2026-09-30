$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [84, 40], [84, 12], [81, 12], [81, 24], [77, 24], [77, 12], [64, 12], [64, 24], [60, 24], [60, 12], [47, 12], [47, 24], [43, 24], [43, 12], [30, 12], [30, 24], [26, 24], [26, 12], [13, 12], [13, 24], [9, 24], [9, 12], [6, 12], [6, 40], [0, 40]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
