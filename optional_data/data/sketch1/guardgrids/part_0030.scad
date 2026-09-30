$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [170, 40], [170, 12], [167, 12], [167, 24], [162, 24], [162, 12], [137.2, 12], [137.2, 24], [132.2, 24], [132.2, 12], [107.4, 12], [107.4, 24], [102.4, 24], [102.4, 12], [77.6, 12], [77.6, 24], [72.6, 24], [72.6, 12], [47.8, 12], [47.8, 24], [42.8, 24], [42.8, 12], [18, 12], [18, 24], [13, 24], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
