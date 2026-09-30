$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 20.0 mm, lift 4.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[44, 20.522], [43.091, 26.725], [40.603, 32.585], [36.601, 37.866], [30.972, 41.98], [24, 44], [16.606, 43.277], [9.893, 39.939], [4.584, 34.629], [1.175, 27.939], [0, 20.522], [1.175, 13.106], [3.079, 5.322], [9.339, 0.342], [17.353, 0.064], [24, 0], [30.203, 1.431], [35.756, 4.342], [40.18, 8.766], [43.021, 14.342]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
