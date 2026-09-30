$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [110, 40], [110, 12], [107, 12], [107, 34], [100, 34], [100, 12], [85.25, 12], [85.25, 34], [78.25, 34], [78.25, 12], [63.5, 12], [63.5, 34], [56.5, 34], [56.5, 12], [41.75, 12], [41.75, 34], [34.75, 34], [34.75, 12], [20, 12], [20, 34], [13, 34], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
