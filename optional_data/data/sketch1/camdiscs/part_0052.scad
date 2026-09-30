$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 6.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[32, 16.301], [31.554, 19.987], [30.446, 23.657], [28.644, 27.431], [25.744, 31.068], [21.514, 33.788], [16.351, 34.726], [11.119, 33.558], [6.558, 30.66], [3.016, 26.573], [0.77, 21.654], [0, 16.301], [0.828, 10.965], [1.099, 4.797], [4.875, 0], [12.021, 1.019], [16.96, 2.113], [20.905, 3.052], [24.413, 4.449], [27.513, 6.476], [29.936, 9.273], [31.473, 12.639]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
