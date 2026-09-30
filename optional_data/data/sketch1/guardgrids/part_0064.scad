$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 90 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 55], [82, 55], [82, 8], [79, 8], [79, 39], [74, 39], [74, 8], [68.5, 8], [68.5, 39], [63.5, 39], [63.5, 8], [58, 8], [58, 39], [53, 39], [53, 8], [47.5, 8], [47.5, 39], [42.5, 39], [42.5, 8], [37, 8], [37, 39], [32, 39], [32, 8], [26.5, 8], [26.5, 39], [21.5, 39], [21.5, 8], [16, 8], [16, 39], [11, 39], [11, 8], [8, 8], [8, 55], [0, 55]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
