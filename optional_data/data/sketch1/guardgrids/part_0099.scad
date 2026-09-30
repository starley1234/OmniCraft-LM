$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [80, 40], [80, 8], [77, 8], [77, 30], [73, 30], [73, 8], [65, 8], [65, 30], [61, 30], [61, 8], [53, 8], [53, 30], [49, 30], [49, 8], [41, 8], [41, 30], [37, 30], [37, 8], [29, 8], [29, 30], [25, 30], [25, 8], [17, 8], [17, 30], [13, 30], [13, 8], [10, 8], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
