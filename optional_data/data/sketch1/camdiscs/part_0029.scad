$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 20.0 mm, lift 12.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[52, 26.614], [51.516, 31.843], [50.017, 37.016], [47.385, 41.999], [43.5, 46.533], [38.327, 50.228], [32, 52.614], [24.869, 53.228], [17.5, 51.729], [10.615, 47.999], [4.983, 42.212], [1.288, 34.843], [0, 26.614], [1.288, 18.385], [4.983, 11.016], [10.615, 5.229], [17.5, 1.499], [24.869, 0], [32, 0.614], [38.327, 3], [44.25, 5.396], [49.506, 9.108], [51.316, 15.462], [51.516, 21.385]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
