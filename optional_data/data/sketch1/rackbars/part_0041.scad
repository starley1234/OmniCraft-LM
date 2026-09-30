$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 10], [67, 10], [66.2, 16], [63.8, 16], [63, 10], [57, 10], [56.2, 16], [53.8, 16], [53, 10], [47, 10], [46.2, 16], [43.8, 16], [43, 10], [37, 10], [36.2, 16], [33.8, 16], [33, 10], [27, 10], [26.2, 16], [23.8, 16], [23, 10], [17, 10], [16.2, 16], [13.8, 16], [13, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
