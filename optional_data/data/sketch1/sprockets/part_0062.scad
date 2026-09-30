$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[48.974, 22.705], [55.008, 32.751], [46.079, 39.292], [43.242, 50.662], [32.303, 48.974], [22.257, 55.008], [15.716, 46.079], [4.346, 43.242], [6.034, 32.303], [0, 22.257], [8.929, 15.716], [11.766, 4.346], [22.705, 6.034], [32.751, 0], [39.292, 8.929], [50.662, 11.766]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
