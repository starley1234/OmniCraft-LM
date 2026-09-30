$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[59.035, 27.989], [67.322, 38.451], [55.613, 47.592], [54.075, 60.85], [39.333, 59.035], [28.87, 67.322], [19.729, 55.613], [6.472, 54.075], [8.287, 39.333], [0, 28.87], [11.708, 19.729], [13.247, 6.472], [27.989, 8.287], [38.451, 0], [47.592, 11.708], [60.85, 13.247]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
