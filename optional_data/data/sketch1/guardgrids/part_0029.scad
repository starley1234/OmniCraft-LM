$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 55], [174, 55], [174, 10], [171, 10], [171, 39], [166, 39], [166, 10], [139.6, 10], [139.6, 39], [134.6, 39], [134.6, 10], [108.2, 10], [108.2, 39], [103.2, 39], [103.2, 10], [76.8, 10], [76.8, 39], [71.8, 39], [71.8, 10], [45.4, 10], [45.4, 39], [40.4, 39], [40.4, 10], [14, 10], [14, 39], [9, 39], [9, 10], [6, 10], [6, 55], [0, 55]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
