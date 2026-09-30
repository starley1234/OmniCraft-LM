$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [80, 40], [80, 8], [77, 8], [77, 24], [70, 24], [70, 8], [65.6, 8], [65.6, 24], [58.6, 24], [58.6, 8], [54.2, 8], [54.2, 24], [47.2, 24], [47.2, 8], [42.8, 8], [42.8, 24], [35.8, 24], [35.8, 8], [31.4, 8], [31.4, 24], [24.4, 24], [24.4, 8], [20, 8], [20, 24], [13, 24], [13, 8], [10, 8], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
