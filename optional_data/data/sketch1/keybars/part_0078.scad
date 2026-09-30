$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 5.967], [1.146, 2.44], [4.146, 0.261], [48.373, 0], [52, 0.771], [54.481, 3.527], [54.869, 7.215], [53.015, 10.426], [49.627, 11.934], [4.146, 11.673], [1.146, 9.494]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
