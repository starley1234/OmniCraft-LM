$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 55], [114, 55], [114, 10], [111, 10], [111, 39], [107, 39], [107, 10], [86.5, 10], [86.5, 39], [82.5, 39], [82.5, 10], [62, 10], [62, 39], [58, 39], [58, 10], [37.5, 10], [37.5, 39], [33.5, 39], [33.5, 10], [13, 10], [13, 39], [9, 39], [9, 10], [6, 10], [6, 55], [0, 55]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
