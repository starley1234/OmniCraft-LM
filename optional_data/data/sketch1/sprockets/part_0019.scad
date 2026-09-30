$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[34.964, 18.551], [43.153, 23.111], [33.499, 28.015], [36.841, 36.772], [26.293, 34.323], [23.224, 43.18], [16.719, 34.523], [8.675, 39.335], [9.255, 28.522], [0, 27.038], [7.395, 19.128], [1.259, 12.042], [12.009, 10.736], [11.863, 1.364], [20.937, 7.273], [26.85, 0], [30.003, 10.359], [39.208, 8.589]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
