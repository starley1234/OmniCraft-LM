$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth on a 200 mm bar, pitch 23 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 8], [183, 8], [182, 17], [179, 17], [178, 8], [160, 8], [159, 17], [156, 17], [155, 8], [137, 8], [136, 17], [133, 17], [132, 8], [114, 8], [113, 17], [110, 17], [109, 8], [91, 8], [90, 17], [87, 17], [86, 8], [68, 8], [67, 17], [64, 17], [63, 8], [45, 8], [44, 17], [41, 17], [40, 8], [22, 8], [21, 17], [18, 17], [17, 8], [0, 8]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
