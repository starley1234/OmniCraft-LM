$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 140 mm bar, pitch 21.33 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [140, 0], [140, 10], [125.333, 10], [124.533, 19], [122.133, 19], [121.333, 10], [104, 10], [103.2, 19], [100.8, 19], [100, 10], [82.667, 10], [81.867, 19], [79.467, 19], [78.667, 10], [61.333, 10], [60.533, 19], [58.133, 19], [57.333, 10], [40, 10], [39.2, 19], [36.8, 19], [36, 10], [18.667, 10], [17.867, 19], [15.467, 19], [14.667, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
