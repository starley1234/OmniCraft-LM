$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 70], [112, 70], [112, 10], [109, 10], [109, 64], [103, 64], [103, 10], [86, 10], [86, 64], [80, 64], [80, 10], [63, 10], [63, 64], [57, 64], [57, 10], [40, 10], [40, 64], [34, 64], [34, 10], [17, 10], [17, 64], [11, 64], [11, 10], [8, 10], [8, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
