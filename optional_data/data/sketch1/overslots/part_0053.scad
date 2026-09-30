$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 40], [173.5, 40], [173.5, 35], [178.5, 35], [178.5, 14], [136.5, 14], [136.5, 35], [141.5, 35], [141.5, 40], [121, 40], [121, 35], [126, 35], [126, 14], [84, 14], [84, 35], [89, 35], [89, 40], [68.5, 40], [68.5, 35], [73.5, 35], [73.5, 14], [31.5, 14], [31.5, 35], [36.5, 35], [36.5, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
