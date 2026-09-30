$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 170 mm bar, pitch 26.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [170, 0], [170, 12], [153.333, 12], [152.333, 18], [149.333, 18], [148.333, 12], [127, 12], [126, 18], [123, 18], [122, 12], [100.667, 12], [99.667, 18], [96.667, 18], [95.667, 12], [74.333, 12], [73.333, 18], [70.333, 18], [69.333, 12], [48, 12], [47, 18], [44, 18], [43, 12], [21.667, 12], [20.667, 18], [17.667, 18], [16.667, 12], [0, 12]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
