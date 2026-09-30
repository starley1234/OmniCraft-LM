$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [170, 40], [170, 12], [167, 12], [167, 24], [163, 24], [163, 12], [137, 12], [137, 24], [133, 24], [133, 12], [107, 12], [107, 24], [103, 24], [103, 12], [77, 12], [77, 24], [73, 24], [73, 12], [47, 12], [47, 24], [43, 24], [43, 12], [17, 12], [17, 24], [13, 24], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
