$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 12.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[34, 15.018], [34.558, 18.411], [35.288, 22.914], [34.667, 28.482], [31.644, 33.946], [26.233, 37.507], [19.727, 37.784], [13.445, 35.939], [7.938, 32.4], [3.651, 27.452], [0.932, 21.497], [0, 15.018], [0.932, 8.538], [4.374, 3.047], [10.104, 0.134], [16.142, 0], [21.085, 1.699], [24.622, 3.736], [27.57, 5.012], [30.203, 6.704], [32.254, 9.071], [33.554, 11.919]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
