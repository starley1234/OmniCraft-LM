$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [110, 40], [110, 10], [107, 10], [107, 24], [101, 24], [101, 10], [89.4, 10], [89.4, 24], [83.4, 24], [83.4, 10], [71.8, 10], [71.8, 24], [65.8, 24], [65.8, 10], [54.2, 10], [54.2, 24], [48.2, 24], [48.2, 10], [36.6, 10], [36.6, 24], [30.6, 24], [30.6, 10], [19, 10], [19, 24], [13, 24], [13, 10], [10, 10], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
