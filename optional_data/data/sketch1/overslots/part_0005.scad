$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [168.25, 50], [168.25, 45], [173.25, 45], [173.25, 28], [141.75, 28], [141.75, 45], [146.75, 45], [146.75, 50], [115.75, 50], [115.75, 45], [120.75, 45], [120.75, 28], [89.25, 28], [89.25, 45], [94.25, 45], [94.25, 50], [63.25, 50], [63.25, 45], [68.25, 45], [68.25, 28], [36.75, 28], [36.75, 45], [41.75, 45], [41.75, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
