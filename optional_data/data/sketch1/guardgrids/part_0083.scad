$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 150 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [150, 0], [150, 70], [144, 70], [144, 8], [141, 8], [141, 54], [135, 54], [135, 8], [120, 8], [120, 54], [114, 54], [114, 8], [99, 8], [99, 54], [93, 54], [93, 8], [78, 8], [78, 54], [72, 54], [72, 8], [57, 8], [57, 54], [51, 54], [51, 8], [36, 8], [36, 54], [30, 54], [30, 8], [15, 8], [15, 54], [9, 54], [9, 8], [6, 8], [6, 70], [0, 70]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
