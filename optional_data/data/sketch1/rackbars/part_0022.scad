$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 31.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 10], [180.333, 10], [179.533, 15], [177.133, 15], [176.333, 10], [149, 10], [148.2, 15], [145.8, 15], [145, 10], [117.667, 10], [116.867, 15], [114.467, 15], [113.667, 10], [86.333, 10], [85.533, 15], [83.133, 15], [82.333, 10], [55, 10], [54.2, 15], [51.8, 15], [51, 10], [23.667, 10], [22.867, 15], [20.467, 15], [19.667, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
