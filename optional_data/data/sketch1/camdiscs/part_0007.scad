$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 10.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[36, 18.588], [35.596, 22.681], [34.29, 26.791], [31.853, 30.773], [28.085, 34.238], [23, 36.588], [16.96, 37.177], [10.692, 35.528], [5.165, 31.546], [1.358, 25.62], [0, 18.588], [1.358, 11.557], [5.165, 5.631], [10.692, 1.649], [16.96, 0], [23, 0.588], [28.085, 2.939], [31.853, 6.404], [34.29, 10.386], [35.596, 14.496]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
