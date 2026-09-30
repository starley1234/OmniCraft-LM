$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 55], [174, 55], [174, 10], [171, 10], [171, 49], [165, 49], [165, 10], [139.8, 10], [139.8, 49], [133.8, 49], [133.8, 10], [108.6, 10], [108.6, 49], [102.6, 49], [102.6, 10], [77.4, 10], [77.4, 49], [71.4, 49], [71.4, 10], [46.2, 10], [46.2, 49], [40.2, 49], [40.2, 10], [15, 10], [15, 49], [9, 49], [9, 10], [6, 10], [6, 55], [0, 55]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
