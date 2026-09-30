$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 150 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [150, 0], [150, 40], [140, 40], [140, 10], [137, 10], [137, 24], [133, 24], [133, 10], [113, 10], [113, 24], [109, 24], [109, 10], [89, 10], [89, 24], [85, 24], [85, 10], [65, 10], [65, 24], [61, 24], [61, 10], [41, 10], [41, 24], [37, 24], [37, 10], [17, 10], [17, 24], [13, 24], [13, 10], [10, 10], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
