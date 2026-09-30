$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 10.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[44, 19.464], [43.525, 23.892], [42.41, 28.361], [40.666, 33.131], [37.762, 38.105], [33.173, 42.501], [27, 45.159], [20.087, 45.266], [13.504, 42.841], [7.908, 38.556], [3.617, 32.964], [0.92, 26.453], [0, 19.464], [1.024, 12.504], [4.305, 6.361], [9.554, 2.018], [15.762, 0], [21.785, 0], [27, 1.159], [31.475, 2.765], [35.504, 4.736], [39.021, 7.444], [41.722, 10.964], [43.421, 15.065]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
