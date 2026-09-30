$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 40], [98, 40], [98, 35], [102, 35], [102, 14], [78, 14], [78, 35], [82, 35], [82, 40], [68, 40], [68, 35], [72, 35], [72, 14], [48, 14], [48, 35], [52, 35], [52, 40], [38, 40], [38, 35], [42, 35], [42, 14], [18, 14], [18, 35], [22, 35], [22, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
