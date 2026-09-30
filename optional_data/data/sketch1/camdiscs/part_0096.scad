$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 12.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[34, 15.216], [33.75, 18.097], [33.351, 21.193], [32.753, 24.969], [31.215, 29.445], [27.974, 33.78], [23, 36.65], [17.137, 37.098], [11.504, 35.128], [6.737, 31.48], [3.081, 26.716], [0.784, 21.169], [0, 15.216], [0.909, 9.297], [3.906, 4.193], [8.711, 0.928], [14.215, 0], [19.174, 0.939], [23, 2.65], [25.937, 4.257], [28.504, 5.683], [30.778, 7.438], [32.526, 9.716], [33.625, 12.369]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
