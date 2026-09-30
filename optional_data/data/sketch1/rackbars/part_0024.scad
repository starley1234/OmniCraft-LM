$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth on a 80 mm bar, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 14], [70, 14], [69.2, 20], [66.8, 20], [66, 14], [62, 14], [61.2, 20], [58.8, 20], [58, 14], [54, 14], [53.2, 20], [50.8, 20], [50, 14], [46, 14], [45.2, 20], [42.8, 20], [42, 14], [38, 14], [37.2, 20], [34.8, 20], [34, 14], [30, 14], [29.2, 20], [26.8, 20], [26, 14], [22, 14], [21.2, 20], [18.8, 20], [18, 14], [14, 14], [13.2, 20], [10.8, 20], [10, 14], [0, 14]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
