$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[67.109, 31.287], [75.663, 41.407], [63.161, 53.906], [62.053, 67.111], [44.376, 67.109], [34.255, 75.663], [21.757, 63.161], [8.552, 62.053], [8.554, 44.376], [0, 34.255], [12.502, 21.757], [13.609, 8.552], [31.287, 8.554], [41.407, 0], [53.906, 12.502], [67.111, 13.609]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
