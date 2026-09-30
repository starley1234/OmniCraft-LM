$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 180 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 70], [170, 70], [170, 8], [167, 8], [167, 54], [163, 54], [163, 8], [129.5, 8], [129.5, 54], [125.5, 54], [125.5, 8], [92, 8], [92, 54], [88, 54], [88, 8], [54.5, 8], [54.5, 54], [50.5, 54], [50.5, 8], [17, 8], [17, 54], [13, 54], [13, 8], [10, 8], [10, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
