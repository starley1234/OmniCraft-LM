$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 30.67 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 12], [178.667, 12], [177.867, 23], [175.467, 23], [174.667, 12], [148, 12], [147.2, 23], [144.8, 23], [144, 12], [117.333, 12], [116.533, 23], [114.133, 23], [113.333, 12], [86.667, 12], [85.867, 23], [83.467, 23], [82.667, 12], [56, 12], [55.2, 23], [52.8, 23], [52, 12], [25.333, 12], [24.533, 23], [22.133, 23], [21.333, 12], [0, 12]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
