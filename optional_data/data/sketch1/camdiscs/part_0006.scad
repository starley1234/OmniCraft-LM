$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 8.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[34, 15.099], [33.504, 19.162], [32.362, 23.354], [30.332, 27.943], [26.601, 32.336], [21, 35.055], [14.556, 34.931], [8.657, 32.088], [4.011, 27.443], [1.028, 21.588], [0, 15.099], [1.168, 8.655], [4.856, 3.369], [10.347, 0.437], [16.094, 0], [21, 1.055], [25.063, 2.595], [28.641, 4.582], [31.517, 7.458], [33.364, 11.082]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
