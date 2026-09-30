$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 200 mm bar, pitch 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 10], [177, 10], [176.2, 21], [173.8, 21], [173, 10], [147, 10], [146.2, 21], [143.8, 21], [143, 10], [117, 10], [116.2, 21], [113.8, 21], [113, 10], [87, 10], [86.2, 21], [83.8, 21], [83, 10], [57, 10], [56.2, 21], [53.8, 21], [53, 10], [27, 10], [26.2, 21], [23.8, 21], [23, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
