$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 31.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 10], [179.833, 10], [179.233, 15], [177.433, 15], [176.833, 10], [148.5, 10], [147.9, 15], [146.1, 15], [145.5, 10], [117.167, 10], [116.567, 15], [114.767, 15], [114.167, 10], [85.833, 10], [85.233, 15], [83.433, 15], [82.833, 10], [54.5, 10], [53.9, 15], [52.1, 15], [51.5, 10], [23.167, 10], [22.567, 15], [20.767, 15], [20.167, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
