$fn = 32;
// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 180 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 70], [174, 70], [174, 10], [171, 10], [171, 54], [164, 54], [164, 10], [132.25, 10], [132.25, 54], [125.25, 54], [125.25, 10], [93.5, 10], [93.5, 54], [86.5, 54], [86.5, 10], [54.75, 10], [54.75, 54], [47.75, 54], [47.75, 10], [16, 10], [16, 54], [9, 54], [9, 10], [6, 10], [6, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
