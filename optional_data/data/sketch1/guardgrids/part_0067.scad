$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [170, 40], [170, 12], [167, 12], [167, 30], [161, 30], [161, 12], [137.4, 12], [137.4, 30], [131.4, 30], [131.4, 12], [107.8, 12], [107.8, 30], [101.8, 30], [101.8, 12], [78.2, 12], [78.2, 30], [72.2, 30], [72.2, 12], [48.6, 12], [48.6, 30], [42.6, 30], [42.6, 12], [19, 12], [19, 30], [13, 30], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
