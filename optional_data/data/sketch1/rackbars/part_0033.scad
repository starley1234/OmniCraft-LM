$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 110 mm bar, pitch 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [110, 0], [110, 8], [95, 8], [94, 13], [91, 13], [90, 8], [80, 8], [79, 13], [76, 13], [75, 8], [65, 8], [64, 13], [61, 13], [60, 8], [50, 8], [49, 13], [46, 13], [45, 8], [35, 8], [34, 13], [31, 13], [30, 8], [20, 8], [19, 13], [16, 13], [15, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
