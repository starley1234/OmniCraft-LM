$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 40 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 40], [80, 40], [80, 8], [77, 8], [77, 34], [71, 34], [71, 8], [65.4, 8], [65.4, 34], [59.4, 34], [59.4, 8], [53.8, 8], [53.8, 34], [47.8, 34], [47.8, 8], [42.2, 8], [42.2, 34], [36.2, 34], [36.2, 8], [30.6, 8], [30.6, 34], [24.6, 34], [24.6, 8], [19, 8], [19, 34], [13, 34], [13, 8], [10, 8], [10, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
