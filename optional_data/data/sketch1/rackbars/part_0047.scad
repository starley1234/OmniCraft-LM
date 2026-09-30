$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 170 mm bar, pitch 25.67 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [170, 0], [170, 12], [150.667, 12], [150.067, 20], [148.267, 20], [147.667, 12], [125, 12], [124.4, 20], [122.6, 20], [122, 12], [99.333, 12], [98.733, 20], [96.933, 20], [96.333, 12], [73.667, 12], [73.067, 20], [71.267, 20], [70.667, 12], [48, 12], [47.4, 20], [45.6, 20], [45, 12], [22.333, 12], [21.733, 20], [19.933, 20], [19.333, 12], [0, 12]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
