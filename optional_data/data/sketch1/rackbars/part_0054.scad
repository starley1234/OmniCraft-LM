$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 170 mm bar, pitch 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [170, 0], [170, 12], [149, 12], [148.4, 18], [146.6, 18], [146, 12], [124, 12], [123.4, 18], [121.6, 18], [121, 12], [99, 12], [98.4, 18], [96.6, 18], [96, 12], [74, 12], [73.4, 18], [71.6, 18], [71, 12], [49, 12], [48.4, 18], [46.6, 18], [46, 12], [24, 12], [23.4, 18], [21.6, 18], [21, 12], [0, 12]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
