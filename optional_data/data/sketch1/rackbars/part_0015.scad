$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth on a 110 mm bar, pitch 15.67 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [110, 0], [110, 10], [96.667, 10], [95.667, 16], [92.667, 16], [91.667, 10], [81, 10], [80, 16], [77, 16], [76, 10], [65.333, 10], [64.333, 16], [61.333, 16], [60.333, 10], [49.667, 10], [48.667, 16], [45.667, 16], [44.667, 10], [34, 10], [33, 16], [30, 16], [29, 10], [18.333, 10], [17.333, 16], [14.333, 16], [13.333, 10], [0, 10]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
