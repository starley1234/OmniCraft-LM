$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[34.371, 0], [33.526, 8.777], [31.022, 17.232], [25.459, 14.984], [23.404, 19.305], [20.849, 23.35], [17.829, 27.06], [14.387, 30.384], [10.573, 33.273], [6.442, 35.685], [2.052, 37.588], [0, 31.95], [7.384, 28.187], [13.638, 22.75], [18.392, 15.962], [21.361, 8.225], [22.371, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
