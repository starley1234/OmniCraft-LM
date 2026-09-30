$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 150 x 55 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [150, 0], [150, 55], [140, 55], [140, 8], [137, 8], [137, 49], [130, 49], [130, 8], [107.75, 8], [107.75, 49], [100.75, 49], [100.75, 8], [78.5, 8], [78.5, 49], [71.5, 49], [71.5, 8], [49.25, 8], [49.25, 49], [42.25, 49], [42.25, 8], [20, 8], [20, 49], [13, 49], [13, 8], [10, 8], [10, 55], [0, 55]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
