$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 6.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[40, 18.187], [39.85, 22.702], [39.07, 27.465], [37.142, 32.329], [33.722, 36.758], [28.838, 39.974], [23, 41.187], [17.047, 40.403], [11.5, 38.105], [6.737, 34.45], [3.081, 29.687], [0.784, 24.14], [0, 18.187], [0.784, 12.234], [3.334, 6.833], [7.653, 2.84], [12.85, 0.607], [18.127, 0], [23, 0.563], [27.405, 1.747], [31.5, 3.464], [35.021, 6.166], [37.722, 9.687], [39.421, 13.787]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
