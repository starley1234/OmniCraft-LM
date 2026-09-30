$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [168.25, 50], [168.25, 47], [173.25, 47], [173.25, 28], [141.75, 28], [141.75, 47], [146.75, 47], [146.75, 50], [115.75, 50], [115.75, 47], [120.75, 47], [120.75, 28], [89.25, 28], [89.25, 47], [94.25, 47], [94.25, 50], [63.25, 50], [63.25, 47], [68.25, 47], [68.25, 28], [36.75, 28], [36.75, 47], [41.75, 47], [41.75, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
