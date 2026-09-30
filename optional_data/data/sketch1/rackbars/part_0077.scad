$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 11.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 14], [70.833, 14], [69.833, 22], [66.833, 22], [65.833, 14], [59.5, 14], [58.5, 22], [55.5, 22], [54.5, 14], [48.167, 14], [47.167, 22], [44.167, 22], [43.167, 14], [36.833, 14], [35.833, 22], [32.833, 22], [31.833, 14], [25.5, 14], [24.5, 22], [21.5, 22], [20.5, 14], [14.167, 14], [13.167, 22], [10.167, 22], [9.167, 14], [0, 14]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
