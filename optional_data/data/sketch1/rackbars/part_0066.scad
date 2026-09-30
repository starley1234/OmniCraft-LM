$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 110 mm bar, pitch 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [110, 0], [110, 14], [94, 14], [93.4, 19], [91.6, 19], [91, 14], [79, 14], [78.4, 19], [76.6, 19], [76, 14], [64, 14], [63.4, 19], [61.6, 19], [61, 14], [49, 14], [48.4, 19], [46.6, 19], [46, 14], [34, 14], [33.4, 19], [31.6, 19], [31, 14], [19, 14], [18.4, 19], [16.6, 19], [16, 14], [0, 14]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
