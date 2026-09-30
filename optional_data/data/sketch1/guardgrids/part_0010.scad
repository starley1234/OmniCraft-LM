$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 120 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 70], [112, 70], [112, 8], [109, 8], [109, 54], [103, 54], [103, 8], [90.6, 8], [90.6, 54], [84.6, 54], [84.6, 8], [72.2, 8], [72.2, 54], [66.2, 54], [66.2, 8], [53.8, 8], [53.8, 54], [47.8, 54], [47.8, 8], [35.4, 8], [35.4, 54], [29.4, 54], [29.4, 8], [17, 8], [17, 54], [11, 54], [11, 8], [8, 8], [8, 70], [0, 70]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
