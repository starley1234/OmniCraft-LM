$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 70], [170, 70], [170, 12], [167, 12], [167, 64], [163, 64], [163, 12], [137, 12], [137, 64], [133, 64], [133, 12], [107, 12], [107, 64], [103, 64], [103, 12], [77, 12], [77, 64], [73, 64], [73, 12], [47, 12], [47, 64], [43, 64], [43, 12], [17, 12], [17, 64], [13, 64], [13, 12], [10, 12], [10, 70], [0, 70]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
