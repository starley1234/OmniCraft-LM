$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[39.66, 18.225], [43.875, 23.033], [38.127, 29.244], [38.711, 35.611], [30.41, 37.257], [27.14, 42.752], [19.457, 39.204], [13.582, 41.728], [9.452, 34.341], [3.216, 32.93], [4.215, 24.526], [0, 19.719], [5.748, 13.508], [5.164, 7.141], [13.465, 5.495], [16.735, 0], [24.418, 3.548], [30.293, 1.024], [34.423, 8.41], [40.659, 9.822]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
