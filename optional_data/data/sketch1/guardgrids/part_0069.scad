$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 120 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [120, 0], [120, 40], [114, 40], [114, 10], [111, 10], [111, 34], [104, 34], [104, 10], [87.25, 10], [87.25, 34], [80.25, 34], [80.25, 10], [63.5, 10], [63.5, 34], [56.5, 34], [56.5, 10], [39.75, 10], [39.75, 34], [32.75, 34], [32.75, 10], [16, 10], [16, 34], [9, 34], [9, 10], [6, 10], [6, 40], [0, 40]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
