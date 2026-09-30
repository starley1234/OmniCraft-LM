$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 120 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 60], [99, 60], [99, 55], [102, 55], [102, 34], [78, 34], [78, 55], [81, 55], [81, 60], [69, 60], [69, 55], [72, 55], [72, 34], [48, 34], [48, 55], [51, 55], [51, 60], [39, 60], [39, 55], [42, 55], [42, 34], [18, 34], [18, 55], [21, 55], [21, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
