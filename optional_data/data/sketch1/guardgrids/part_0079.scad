$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 55], [82, 55], [82, 10], [79, 10], [79, 49], [74, 49], [74, 10], [66.4, 10], [66.4, 49], [61.4, 49], [61.4, 10], [53.8, 10], [53.8, 49], [48.8, 49], [48.8, 10], [41.2, 10], [41.2, 49], [36.2, 49], [36.2, 10], [28.6, 10], [28.6, 49], [23.6, 49], [23.6, 10], [16, 10], [16, 49], [11, 49], [11, 10], [8, 10], [8, 55], [0, 55]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
