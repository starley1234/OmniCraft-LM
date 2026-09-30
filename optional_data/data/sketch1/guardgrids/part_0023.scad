$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [172, 40], [172, 8], [169, 8], [169, 24], [162, 24], [162, 8], [131.25, 8], [131.25, 24], [124.25, 24], [124.25, 8], [93.5, 8], [93.5, 24], [86.5, 24], [86.5, 8], [55.75, 8], [55.75, 24], [48.75, 24], [48.75, 8], [18, 8], [18, 24], [11, 24], [11, 8], [8, 8], [8, 40], [0, 40]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
