$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 55], [110, 55], [110, 12], [107, 12], [107, 45], [100, 45], [100, 12], [85.25, 12], [85.25, 45], [78.25, 45], [78.25, 12], [63.5, 12], [63.5, 45], [56.5, 45], [56.5, 12], [41.75, 12], [41.75, 45], [34.75, 45], [34.75, 12], [20, 12], [20, 45], [13, 45], [13, 12], [10, 12], [10, 55], [0, 55]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
