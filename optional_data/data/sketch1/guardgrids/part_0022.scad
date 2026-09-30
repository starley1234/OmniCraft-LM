$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [80, 40], [80, 12], [77, 12], [77, 24], [73, 24], [73, 12], [65, 12], [65, 24], [61, 24], [61, 12], [53, 12], [53, 24], [49, 24], [49, 12], [41, 12], [41, 24], [37, 24], [37, 12], [29, 12], [29, 24], [25, 24], [25, 12], [17, 12], [17, 24], [13, 24], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
