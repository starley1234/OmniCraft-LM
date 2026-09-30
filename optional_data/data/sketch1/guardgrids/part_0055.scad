$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 40], [174, 40], [174, 8], [171, 8], [171, 24], [166, 24], [166, 8], [139.6, 8], [139.6, 24], [134.6, 24], [134.6, 8], [108.2, 8], [108.2, 24], [103.2, 24], [103.2, 8], [76.8, 8], [76.8, 24], [71.8, 24], [71.8, 8], [45.4, 8], [45.4, 24], [40.4, 24], [40.4, 8], [14, 8], [14, 24], [9, 24], [9, 8], [6, 8], [6, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
