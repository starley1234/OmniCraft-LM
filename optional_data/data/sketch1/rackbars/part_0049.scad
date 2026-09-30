$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 10], [67.5, 10], [66.5, 15], [63.5, 15], [62.5, 10], [57.5, 10], [56.5, 15], [53.5, 15], [52.5, 10], [47.5, 10], [46.5, 15], [43.5, 15], [42.5, 10], [37.5, 10], [36.5, 15], [33.5, 15], [32.5, 10], [27.5, 10], [26.5, 15], [23.5, 15], [22.5, 10], [17.5, 10], [16.5, 15], [13.5, 15], [12.5, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
