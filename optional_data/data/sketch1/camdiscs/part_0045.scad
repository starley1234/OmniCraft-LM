$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 15.0 mm, lift 4.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[34, 15.727], [33.446, 19.969], [31.958, 24.055], [29.577, 27.934], [26.127, 31.333], [21.577, 33.654], [16.333, 34.279], [11.115, 32.993], [6.558, 30.087], [3.016, 26], [0.77, 21.08], [0, 15.727], [0.823, 10.39], [3.356, 5.673], [7.312, 2.238], [12.003, 0.405], [16.739, 0], [21.171, 0.625], [25.239, 2.065], [28.823, 4.391], [31.619, 7.618], [33.392, 11.501]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
