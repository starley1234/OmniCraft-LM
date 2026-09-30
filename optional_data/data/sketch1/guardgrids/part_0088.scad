$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 55], [80, 55], [80, 10], [77, 10], [77, 49], [72, 49], [72, 10], [65.2, 10], [65.2, 49], [60.2, 49], [60.2, 10], [53.4, 10], [53.4, 49], [48.4, 49], [48.4, 10], [41.6, 10], [41.6, 49], [36.6, 49], [36.6, 10], [29.8, 10], [29.8, 49], [24.8, 49], [24.8, 10], [18, 10], [18, 49], [13, 49], [13, 10], [10, 10], [10, 55], [0, 55]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
