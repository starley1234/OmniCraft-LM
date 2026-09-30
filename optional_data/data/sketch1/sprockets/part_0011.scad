$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[49.062, 24.419], [55.277, 29.841], [47.509, 36.718], [49.806, 44.639], [39.552, 46.224], [37.203, 54.129], [27.72, 49.92], [21.469, 55.3], [15.768, 46.632], [7.601, 47.778], [7.491, 37.404], [0, 33.953], [5.516, 25.166], [1.081, 18.213], [10.472, 13.803], [10.499, 5.556], [20.784, 6.923], [25.266, 0], [33.179, 6.711], [40.692, 3.31], [43.72, 13.233], [51.88, 14.434]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
