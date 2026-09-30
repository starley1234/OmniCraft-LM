$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 80 mm bar, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 8], [66.5, 8], [65.9, 17], [64.1, 17], [63.5, 8], [56.5, 8], [55.9, 17], [54.1, 17], [53.5, 8], [46.5, 8], [45.9, 17], [44.1, 17], [43.5, 8], [36.5, 8], [35.9, 17], [34.1, 17], [33.5, 8], [26.5, 8], [25.9, 17], [24.1, 17], [23.5, 8], [16.5, 8], [15.9, 17], [14.1, 17], [13.5, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
