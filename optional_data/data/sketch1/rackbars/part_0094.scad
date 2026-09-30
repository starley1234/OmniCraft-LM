$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth on a 80 mm bar, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 10], [70, 10], [69.2, 18], [66.8, 18], [66, 10], [62, 10], [61.2, 18], [58.8, 18], [58, 10], [54, 10], [53.2, 18], [50.8, 18], [50, 10], [46, 10], [45.2, 18], [42.8, 18], [42, 10], [38, 10], [37.2, 18], [34.8, 18], [34, 10], [30, 10], [29.2, 18], [26.8, 18], [26, 10], [22, 10], [21.2, 18], [18.8, 18], [18, 10], [14, 10], [13.2, 18], [10.8, 18], [10, 10], [0, 10]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
