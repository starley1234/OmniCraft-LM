$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[41.207, 21.067], [47.381, 25.578], [39.936, 31.13], [42.691, 38.262], [33.426, 38.907], [31.888, 46.397], [23.745, 41.931], [18.402, 47.4], [13.966, 39.241], [6.515, 40.953], [7.194, 31.691], [0, 29.102], [5.579, 21.678], [0.926, 15.611], [9.633, 12.381], [8.999, 4.762], [18.07, 6.752], [21.656, 0], [28.211, 6.579], [34.879, 2.837], [36.836, 11.915], [44.468, 12.372]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
