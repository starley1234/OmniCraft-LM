$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 30.67 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 8], [178.667, 8], [177.867, 16], [175.467, 16], [174.667, 8], [148, 8], [147.2, 16], [144.8, 16], [144, 8], [117.333, 8], [116.533, 16], [114.133, 16], [113.333, 8], [86.667, 8], [85.867, 16], [83.467, 16], [82.667, 8], [56, 8], [55.2, 16], [52.8, 16], [52, 8], [25.333, 8], [24.533, 16], [22.133, 16], [21.333, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
