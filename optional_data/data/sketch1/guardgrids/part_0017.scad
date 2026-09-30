$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [110, 40], [110, 8], [107, 8], [107, 24], [102, 24], [102, 8], [89.2, 8], [89.2, 24], [84.2, 24], [84.2, 8], [71.4, 8], [71.4, 24], [66.4, 24], [66.4, 8], [53.6, 8], [53.6, 24], [48.6, 24], [48.6, 8], [35.8, 8], [35.8, 24], [30.8, 24], [30.8, 8], [18, 8], [18, 24], [13, 24], [13, 8], [10, 8], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
