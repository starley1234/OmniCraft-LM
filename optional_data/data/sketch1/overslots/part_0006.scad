$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 40], [163, 40], [163, 35], [168, 35], [168, 14], [112, 14], [112, 35], [117, 35], [117, 40], [93, 40], [93, 35], [98, 35], [98, 14], [42, 14], [42, 35], [47, 35], [47, 40], [0, 40]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
