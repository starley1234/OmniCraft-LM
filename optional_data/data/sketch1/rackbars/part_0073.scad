$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 8], [177.5, 8], [176.5, 16], [173.5, 16], [172.5, 8], [147.5, 8], [146.5, 16], [143.5, 16], [142.5, 8], [117.5, 8], [116.5, 16], [113.5, 16], [112.5, 8], [87.5, 8], [86.5, 16], [83.5, 16], [82.5, 8], [57.5, 8], [56.5, 16], [53.5, 16], [52.5, 8], [27.5, 8], [26.5, 16], [23.5, 16], [22.5, 8], [0, 8]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
