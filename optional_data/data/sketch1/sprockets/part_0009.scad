$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[56.979, 25.096], [63.026, 35.482], [54.258, 42.671], [52.214, 54.515], [40.877, 54.386], [31.698, 62.145], [23.095, 54.759], [11.077, 54.802], [9.235, 43.615], [0, 35.922], [5.78, 26.168], [3.65, 14.34], [14.348, 10.583], [20.32, 0.153], [30.93, 4.152], [42.209, 0], [47.766, 9.883], [59.075, 13.953]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
