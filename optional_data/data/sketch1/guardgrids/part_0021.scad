$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [172, 40], [172, 8], [169, 8], [169, 34], [164, 34], [164, 8], [143.5, 8], [143.5, 34], [138.5, 34], [138.5, 8], [118, 8], [118, 34], [113, 34], [113, 8], [92.5, 8], [92.5, 34], [87.5, 34], [87.5, 8], [67, 8], [67, 34], [62, 34], [62, 8], [41.5, 8], [41.5, 34], [36.5, 34], [36.5, 8], [16, 8], [16, 34], [11, 34], [11, 8], [8, 8], [8, 40], [0, 40]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
