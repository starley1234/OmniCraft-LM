$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 30 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[65.017, 31.194], [71.21, 39.666], [62.899, 47.964], [63.528, 58.44], [52.05, 60.927], [46.915, 70.08], [35.914, 65.967], [26.647, 70.891], [19.616, 61.483], [9.157, 60.615], [8.329, 48.899], [0, 42.515], [5.637, 32.211], [2.082, 22.337], [12.395, 16.717], [14.742, 6.488], [26.456, 7.335], [33.961, 0], [43.358, 7.046], [53.637, 4.932], [57.733, 15.94], [67.523, 19.719]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
