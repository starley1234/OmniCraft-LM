$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[33.309, 16.592], [39.291, 23.393], [31.466, 27.147], [30.887, 36.187], [22.7, 33.309], [15.898, 39.291], [12.144, 31.466], [3.104, 30.887], [5.983, 22.7], [0, 15.898], [7.825, 12.144], [8.404, 3.104], [16.592, 5.983], [23.393, 0], [27.147, 7.825], [36.187, 8.404]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
