$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 4.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[38, 19.088], [37.389, 23.901], [35.568, 28.451], [32.585, 32.458], [28.548, 35.616], [23.663, 37.613], [18.256, 38.177], [12.762, 37.127], [7.7, 34.437], [3.601, 30.27], [0.928, 24.982], [0, 19.088], [0.928, 13.195], [3.601, 7.907], [7.7, 3.739], [12.762, 1.05], [18.256, 0], [23.663, 0.563], [28.548, 2.561], [32.585, 5.719], [35.568, 9.726], [37.389, 14.276]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
