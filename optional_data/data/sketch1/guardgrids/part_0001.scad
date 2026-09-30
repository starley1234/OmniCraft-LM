$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 120 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 70], [110, 70], [110, 8], [107, 8], [107, 64], [103, 64], [103, 8], [92, 8], [92, 64], [88, 64], [88, 8], [77, 8], [77, 64], [73, 64], [73, 8], [62, 8], [62, 64], [58, 64], [58, 8], [47, 8], [47, 64], [43, 64], [43, 8], [32, 8], [32, 64], [28, 64], [28, 8], [17, 8], [17, 64], [13, 64], [13, 8], [10, 8], [10, 70], [0, 70]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
