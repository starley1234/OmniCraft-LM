$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 40], [89, 40], [89, 35], [94, 35], [94, 18], [66, 18], [66, 35], [71, 35], [71, 40], [49, 40], [49, 35], [54, 35], [54, 18], [26, 18], [26, 35], [31, 35], [31, 40], [0, 40]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
