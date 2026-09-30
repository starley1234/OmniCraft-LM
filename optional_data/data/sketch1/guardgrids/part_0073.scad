$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 180 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 55], [172, 55], [172, 12], [169, 12], [169, 49], [162, 49], [162, 12], [131.25, 12], [131.25, 49], [124.25, 49], [124.25, 12], [93.5, 12], [93.5, 49], [86.5, 49], [86.5, 12], [55.75, 12], [55.75, 49], [48.75, 49], [48.75, 12], [18, 12], [18, 49], [11, 49], [11, 12], [8, 12], [8, 55], [0, 55]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
