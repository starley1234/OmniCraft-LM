$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [112, 40], [112, 10], [109, 10], [109, 34], [104, 34], [104, 10], [90.4, 10], [90.4, 34], [85.4, 34], [85.4, 10], [71.8, 10], [71.8, 34], [66.8, 34], [66.8, 10], [53.2, 10], [53.2, 34], [48.2, 34], [48.2, 10], [34.6, 10], [34.6, 34], [29.6, 34], [29.6, 10], [16, 10], [16, 34], [11, 34], [11, 10], [8, 10], [8, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
