$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 60], [97, 60], [97, 57], [102, 57], [102, 30], [78, 30], [78, 57], [83, 57], [83, 60], [67, 60], [67, 57], [72, 57], [72, 30], [48, 30], [48, 57], [53, 57], [53, 60], [37, 60], [37, 57], [42, 57], [42, 30], [18, 30], [18, 57], [23, 57], [23, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
