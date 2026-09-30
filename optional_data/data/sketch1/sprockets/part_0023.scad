$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[51.015, 26.414], [59.226, 31.972], [49.462, 38.712], [53.364, 47.827], [41.506, 48.218], [39.86, 57.996], [29.673, 51.914], [23.003, 59.25], [17.721, 48.626], [8.144, 51.191], [9.444, 39.398], [0, 36.378], [7.47, 27.16], [1.158, 19.514], [12.425, 15.797], [11.249, 5.953], [22.737, 8.918], [27.07, 0], [35.132, 8.705], [43.598, 3.546], [45.673, 15.228], [55.585, 15.465]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
