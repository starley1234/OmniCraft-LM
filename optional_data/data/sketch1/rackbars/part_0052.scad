$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 11.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 8], [70.833, 8], [69.833, 17], [66.833, 17], [65.833, 8], [59.5, 8], [58.5, 17], [55.5, 17], [54.5, 8], [48.167, 8], [47.167, 17], [44.167, 17], [43.167, 8], [36.833, 8], [35.833, 17], [32.833, 17], [31.833, 8], [25.5, 8], [24.5, 17], [21.5, 17], [20.5, 8], [14.167, 8], [13.167, 17], [10.167, 17], [9.167, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
