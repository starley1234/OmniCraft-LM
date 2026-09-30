$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 10.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[32, 16.504], [32.341, 19.543], [32.772, 23.3], [32.314, 27.818], [30.204, 32.445], [26.243, 36.073], [21, 37.504], [15.565, 36.788], [10.5, 34.69], [6.151, 31.353], [2.813, 27.004], [0.716, 21.939], [0, 16.504], [0.716, 11.069], [1.286, 5.122], [4.496, 0], [11.625, 0.267], [17.364, 2.935], [21, 4.464], [23.855, 5.847], [26.5, 6.978], [28.778, 8.726], [30.526, 11.004], [31.625, 13.657]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
