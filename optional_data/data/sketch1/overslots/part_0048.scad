$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [164, 50], [164, 45], [168, 45], [168, 28], [112, 28], [112, 45], [116, 45], [116, 50], [94, 50], [94, 45], [98, 45], [98, 28], [42, 28], [42, 45], [46, 45], [46, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
