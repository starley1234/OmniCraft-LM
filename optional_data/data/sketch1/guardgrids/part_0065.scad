$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 6 slats over a 180 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [180, 0], [180, 70], [172, 70], [172, 12], [169, 12], [169, 54], [162, 54], [162, 12], [138.8, 12], [138.8, 54], [131.8, 54], [131.8, 12], [108.6, 12], [108.6, 54], [101.6, 54], [101.6, 12], [78.4, 12], [78.4, 54], [71.4, 54], [71.4, 12], [48.2, 12], [48.2, 54], [41.2, 54], [41.2, 12], [18, 12], [18, 54], [11, 54], [11, 12], [8, 12], [8, 70], [0, 70]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
