$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 6.0 mm, 24 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[32, 14.323], [31.986, 17.803], [31.605, 21.601], [30.314, 25.637], [27.722, 29.431], [23.803, 32.246], [19, 33.323], [14.082, 32.676], [9.5, 30.778], [5.565, 27.758], [2.546, 23.823], [0.647, 19.241], [0, 14.323], [0.647, 9.406], [2.798, 4.969], [6.481, 1.805], [10.85, 0.207], [15.162, 0], [19, 0.699], [22.37, 1.747], [25.5, 3.065], [28.192, 5.131], [30.258, 7.823], [31.557, 10.959]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
