$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 10], [67, 10], [66.2, 15], [63.8, 15], [63, 10], [57, 10], [56.2, 15], [53.8, 15], [53, 10], [47, 10], [46.2, 15], [43.8, 15], [43, 10], [37, 10], [36.2, 15], [33.8, 15], [33, 10], [27, 10], [26.2, 15], [23.8, 15], [23, 10], [17, 10], [16.2, 15], [13.8, 15], [13, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
