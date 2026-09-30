$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 30.67 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 8], [179.167, 8], [178.167, 14], [175.167, 14], [174.167, 8], [148.5, 8], [147.5, 14], [144.5, 14], [143.5, 8], [117.833, 8], [116.833, 14], [113.833, 14], [112.833, 8], [87.167, 8], [86.167, 14], [83.167, 14], [82.167, 8], [56.5, 8], [55.5, 14], [52.5, 14], [51.5, 8], [25.833, 8], [24.833, 14], [21.833, 14], [20.833, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
