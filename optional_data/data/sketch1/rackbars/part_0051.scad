$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 12], [67, 12], [66.2, 18], [63.8, 18], [63, 12], [57, 12], [56.2, 18], [53.8, 18], [53, 12], [47, 12], [46.2, 18], [43.8, 18], [43, 12], [37, 12], [36.2, 18], [33.8, 18], [33, 12], [27, 12], [26.2, 18], [23.8, 18], [23, 12], [17, 12], [16.2, 18], [13.8, 18], [13, 12], [0, 12]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
