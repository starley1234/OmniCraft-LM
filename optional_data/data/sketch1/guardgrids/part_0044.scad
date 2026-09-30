$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 70], [110, 70], [110, 12], [107, 12], [107, 54], [103, 54], [103, 12], [84.5, 12], [84.5, 54], [80.5, 54], [80.5, 12], [62, 12], [62, 54], [58, 54], [58, 12], [39.5, 12], [39.5, 54], [35.5, 54], [35.5, 12], [17, 12], [17, 54], [13, 54], [13, 12], [10, 12], [10, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
