$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [82, 40], [82, 10], [79, 10], [79, 24], [74, 24], [74, 10], [68.5, 10], [68.5, 24], [63.5, 24], [63.5, 10], [58, 10], [58, 24], [53, 24], [53, 10], [47.5, 10], [47.5, 24], [42.5, 24], [42.5, 10], [37, 10], [37, 24], [32, 24], [32, 10], [26.5, 10], [26.5, 24], [21.5, 24], [21.5, 10], [16, 10], [16, 24], [11, 24], [11, 10], [8, 10], [8, 40], [0, 40]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
