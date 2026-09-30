$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 90 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 70], [84, 70], [84, 12], [81, 12], [81, 64], [75, 64], [75, 12], [64.5, 12], [64.5, 64], [58.5, 64], [58.5, 12], [48, 12], [48, 64], [42, 64], [42, 12], [31.5, 12], [31.5, 64], [25.5, 64], [25.5, 12], [15, 12], [15, 64], [9, 64], [9, 12], [6, 12], [6, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
