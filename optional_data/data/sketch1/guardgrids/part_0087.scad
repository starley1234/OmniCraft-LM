$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 90 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 70], [82, 70], [82, 10], [79, 10], [79, 54], [75, 54], [75, 10], [66.2, 10], [66.2, 54], [62.2, 54], [62.2, 10], [53.4, 10], [53.4, 54], [49.4, 54], [49.4, 10], [40.6, 10], [40.6, 54], [36.6, 54], [36.6, 10], [27.8, 10], [27.8, 54], [23.8, 54], [23.8, 10], [15, 10], [15, 54], [11, 54], [11, 10], [8, 10], [8, 70], [0, 70]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
