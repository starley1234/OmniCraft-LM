$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 8.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[30, 13.197], [29.602, 16.642], [28.744, 20.277], [27.156, 24.423], [23.983, 28.532], [19, 31.153], [13.174, 31.127], [7.832, 28.568], [3.629, 24.365], [0.93, 19.068], [0, 13.197], [1.07, 7.371], [4.474, 2.643], [9.523, 0.153], [14.712, 0], [19, 1.153], [22.445, 2.595], [25.466, 4.298], [27.899, 6.731], [29.462, 9.798]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
