$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 6.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[28, 12.451], [27.688, 15.315], [26.939, 18.19], [25.765, 21.217], [23.857, 24.329], [21.493, 29.219], [17, 33.168], [12.063, 30.878], [8.502, 27.17], [4.979, 24.472], [2.278, 20.951], [0.579, 16.851], [0, 12.451], [0.642, 8.068], [2.69, 4.19], [5.966, 1.418], [9.857, 0.08], [13.664, 0], [17, 0.668], [19.892, 1.659], [22.502, 2.921], [24.778, 4.673], [26.526, 6.951], [27.625, 9.604]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
