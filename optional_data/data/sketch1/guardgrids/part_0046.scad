$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [84, 40], [84, 12], [81, 12], [81, 24], [75, 24], [75, 12], [67.8, 12], [67.8, 24], [61.8, 24], [61.8, 12], [54.6, 12], [54.6, 24], [48.6, 24], [48.6, 12], [41.4, 12], [41.4, 24], [35.4, 24], [35.4, 12], [28.2, 12], [28.2, 24], [22.2, 24], [22.2, 12], [15, 12], [15, 24], [9, 24], [9, 12], [6, 12], [6, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
