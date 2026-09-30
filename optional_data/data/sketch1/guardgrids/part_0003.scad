$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 150 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [150, 0], [150, 55], [140, 55], [140, 12], [137, 12], [137, 49], [132, 49], [132, 12], [113.2, 12], [113.2, 49], [108.2, 49], [108.2, 12], [89.4, 12], [89.4, 49], [84.4, 49], [84.4, 12], [65.6, 12], [65.6, 49], [60.6, 49], [60.6, 12], [41.8, 12], [41.8, 49], [36.8, 49], [36.8, 12], [18, 12], [18, 49], [13, 49], [13, 12], [10, 12], [10, 55], [0, 55]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
