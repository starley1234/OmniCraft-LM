$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 90 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 55], [82, 55], [82, 10], [79, 10], [79, 39], [74, 39], [74, 10], [68.5, 10], [68.5, 39], [63.5, 39], [63.5, 10], [58, 10], [58, 39], [53, 39], [53, 10], [47.5, 10], [47.5, 39], [42.5, 39], [42.5, 10], [37, 10], [37, 39], [32, 39], [32, 10], [26.5, 10], [26.5, 39], [21.5, 39], [21.5, 10], [16, 10], [16, 39], [11, 39], [11, 10], [8, 10], [8, 55], [0, 55]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
