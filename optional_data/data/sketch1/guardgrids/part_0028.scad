$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [110, 40], [110, 12], [107, 12], [107, 34], [101, 34], [101, 12], [85, 12], [85, 34], [79, 34], [79, 12], [63, 12], [63, 34], [57, 34], [57, 12], [41, 12], [41, 34], [35, 34], [35, 12], [19, 12], [19, 34], [13, 34], [13, 12], [10, 12], [10, 40], [0, 40]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
