$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 55], [114, 55], [114, 8], [111, 8], [111, 45], [107, 45], [107, 8], [86.5, 8], [86.5, 45], [82.5, 45], [82.5, 8], [62, 8], [62, 45], [58, 45], [58, 8], [37.5, 8], [37.5, 45], [33.5, 45], [33.5, 8], [13, 8], [13, 45], [9, 45], [9, 8], [6, 8], [6, 55], [0, 55]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
