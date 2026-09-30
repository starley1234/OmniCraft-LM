$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 4.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[30, 13.748], [29.527, 17.426], [28.276, 20.994], [26.267, 24.443], [23.296, 27.534], [19.293, 29.695], [14.617, 30.32], [9.946, 29.194], [5.867, 26.595], [2.699, 22.939], [0.689, 18.537], [0, 13.748], [0.742, 8.974], [3.038, 4.775], [6.621, 1.77], [10.833, 0.245], [15.023, 0], [18.887, 0.625], [22.408, 1.905], [25.513, 3.923], [27.936, 6.719], [29.473, 10.085]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
