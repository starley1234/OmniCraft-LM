$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 50], [97, 50], [97, 45], [102, 45], [102, 24], [78, 24], [78, 45], [83, 45], [83, 50], [67, 50], [67, 45], [72, 45], [72, 24], [48, 24], [48, 45], [53, 45], [53, 50], [37, 50], [37, 45], [42, 45], [42, 24], [18, 24], [18, 45], [23, 45], [23, 50], [0, 50]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
