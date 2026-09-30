$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 50], [99, 50], [99, 47], [102, 47], [102, 28], [78, 28], [78, 47], [81, 47], [81, 50], [69, 50], [69, 47], [72, 47], [72, 28], [48, 28], [48, 47], [51, 47], [51, 50], [39, 50], [39, 47], [42, 47], [42, 28], [18, 28], [18, 47], [21, 47], [21, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
