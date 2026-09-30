$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [80, 40], [80, 12], [77, 12], [77, 30], [72, 30], [72, 12], [65.2, 12], [65.2, 30], [60.2, 30], [60.2, 12], [53.4, 12], [53.4, 30], [48.4, 30], [48.4, 12], [41.6, 12], [41.6, 30], [36.6, 30], [36.6, 12], [29.8, 12], [29.8, 30], [24.8, 30], [24.8, 12], [18, 12], [18, 30], [13, 30], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
