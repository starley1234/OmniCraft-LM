$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 90 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 55], [80, 55], [80, 12], [77, 12], [77, 49], [73, 49], [73, 12], [67, 12], [67, 49], [63, 49], [63, 12], [57, 12], [57, 49], [53, 49], [53, 12], [47, 12], [47, 49], [43, 49], [43, 12], [37, 12], [37, 49], [33, 49], [33, 12], [27, 12], [27, 49], [23, 49], [23, 12], [17, 12], [17, 49], [13, 49], [13, 12], [10, 12], [10, 55], [0, 55]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
