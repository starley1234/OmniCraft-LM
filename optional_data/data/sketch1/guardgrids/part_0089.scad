$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 55], [114, 55], [114, 8], [111, 8], [111, 49], [104, 49], [104, 8], [87.25, 8], [87.25, 49], [80.25, 49], [80.25, 8], [63.5, 8], [63.5, 49], [56.5, 49], [56.5, 8], [39.75, 8], [39.75, 49], [32.75, 49], [32.75, 8], [16, 8], [16, 49], [9, 49], [9, 8], [6, 8], [6, 55], [0, 55]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
