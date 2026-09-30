$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [110, 40], [110, 10], [107, 10], [107, 24], [100, 24], [100, 10], [85.25, 10], [85.25, 24], [78.25, 24], [78.25, 10], [63.5, 10], [63.5, 24], [56.5, 24], [56.5, 10], [41.75, 10], [41.75, 24], [34.75, 24], [34.75, 10], [20, 10], [20, 24], [13, 24], [13, 10], [10, 10], [10, 40], [0, 40]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
