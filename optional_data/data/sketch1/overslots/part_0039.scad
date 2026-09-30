$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [160.5, 50], [160.5, 45], [164.5, 45], [164.5, 28], [115.5, 28], [115.5, 45], [119.5, 45], [119.5, 50], [90.5, 50], [90.5, 45], [94.5, 45], [94.5, 28], [45.5, 28], [45.5, 45], [49.5, 45], [49.5, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
