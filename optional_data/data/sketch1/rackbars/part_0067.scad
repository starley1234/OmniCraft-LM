$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 7 teeth on a 110 mm bar, pitch 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 0], [110, 0], [110, 8], [98.5, 8], [97.9, 14], [96.1, 14], [95.5, 8], [84.5, 8], [83.9, 14], [82.1, 14], [81.5, 8], [70.5, 8], [69.9, 14], [68.1, 14], [67.5, 8], [56.5, 8], [55.9, 14], [54.1, 14], [53.5, 8], [42.5, 8], [41.9, 14], [40.1, 14], [39.5, 8], [28.5, 8], [27.9, 14], [26.1, 14], [25.5, 8], [14.5, 8], [13.9, 14], [12.1, 14], [11.5, 8], [0, 8]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
