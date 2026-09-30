$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth on a 200 mm bar, pitch 23 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 36;      // points of the closed outline

profile = [[0, 0], [200, 0], [200, 10], [183, 10], [182, 21], [179, 21], [178, 10], [160, 10], [159, 21], [156, 21], [155, 10], [137, 10], [136, 21], [133, 21], [132, 10], [114, 10], [113, 21], [110, 21], [109, 10], [91, 10], [90, 21], [87, 21], [86, 10], [68, 10], [67, 21], [64, 21], [63, 10], [45, 10], [44, 21], [41, 21], [40, 10], [22, 10], [21, 21], [18, 21], [17, 10], [0, 10]];  // single closed polygon, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
