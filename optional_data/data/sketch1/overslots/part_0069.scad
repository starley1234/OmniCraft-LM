$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [159.5, 50], [159.5, 47], [164.5, 47], [164.5, 28], [115.5, 28], [115.5, 47], [120.5, 47], [120.5, 50], [89.5, 50], [89.5, 47], [94.5, 47], [94.5, 28], [45.5, 28], [45.5, 47], [50.5, 47], [50.5, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
