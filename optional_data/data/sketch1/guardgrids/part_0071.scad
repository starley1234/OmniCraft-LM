$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 7 slats over a 90 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 70], [82, 70], [82, 10], [79, 10], [79, 60], [74, 60], [74, 10], [68.5, 10], [68.5, 60], [63.5, 60], [63.5, 10], [58, 10], [58, 60], [53, 60], [53, 10], [47.5, 10], [47.5, 60], [42.5, 60], [42.5, 10], [37, 10], [37, 60], [32, 60], [32, 10], [26.5, 10], [26.5, 60], [21.5, 60], [21.5, 10], [16, 10], [16, 60], [11, 60], [11, 10], [8, 10], [8, 70], [0, 70]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
