$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 140 mm bar, pitch 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [140, 0], [140, 14], [122, 14], [121.2, 20], [118.8, 20], [118, 14], [102, 14], [101.2, 20], [98.8, 20], [98, 14], [82, 14], [81.2, 20], [78.8, 20], [78, 14], [62, 14], [61.2, 20], [58.8, 20], [58, 14], [42, 14], [41.2, 20], [38.8, 20], [38, 14], [22, 14], [21.2, 20], [18.8, 20], [18, 14], [0, 14]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
