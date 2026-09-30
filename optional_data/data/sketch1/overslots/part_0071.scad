$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 40], [159.5, 40], [159.5, 35], [164.5, 35], [164.5, 18], [115.5, 18], [115.5, 35], [120.5, 35], [120.5, 40], [89.5, 40], [89.5, 35], [94.5, 35], [94.5, 18], [45.5, 18], [45.5, 35], [50.5, 35], [50.5, 40], [0, 40]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
