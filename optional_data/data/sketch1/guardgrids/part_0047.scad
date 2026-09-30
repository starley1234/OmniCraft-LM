$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 150 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [150, 0], [150, 70], [140, 70], [140, 12], [137, 12], [137, 60], [133, 60], [133, 12], [113, 12], [113, 60], [109, 60], [109, 12], [89, 12], [89, 60], [85, 60], [85, 12], [65, 12], [65, 60], [61, 60], [61, 12], [41, 12], [41, 60], [37, 60], [37, 12], [17, 12], [17, 60], [13, 60], [13, 12], [10, 12], [10, 70], [0, 70]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
