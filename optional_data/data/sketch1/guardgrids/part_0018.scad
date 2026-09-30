$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [170, 40], [170, 12], [167, 12], [167, 30], [163, 30], [163, 12], [137, 12], [137, 30], [133, 30], [133, 12], [107, 12], [107, 30], [103, 30], [103, 12], [77, 12], [77, 30], [73, 30], [73, 12], [47, 12], [47, 30], [43, 30], [43, 12], [17, 12], [17, 30], [13, 30], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
