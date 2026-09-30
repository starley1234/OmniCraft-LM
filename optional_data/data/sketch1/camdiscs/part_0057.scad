$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 4.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[30, 13.678], [29.808, 17.439], [28.948, 21.356], [27.001, 25.22], [23.759, 28.477], [19.406, 30.413], [14.581, 30.505], [9.938, 29.142], [5.867, 26.526], [2.699, 22.869], [0.689, 18.467], [0, 13.678], [0.689, 8.888], [2.94, 4.642], [6.589, 1.663], [10.837, 0.182], [15.033, 0], [18.869, 0.679], [22.4, 1.853], [25.513, 3.853], [27.936, 6.65], [29.473, 10.015]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
