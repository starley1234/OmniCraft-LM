$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [25, 0], [27.121, 0.879], [28, 3], [28, 19], [27.121, 21.121], [25, 22], [21, 22], [18.879, 21.121], [18, 19], [18, 17], [17.121, 14.879], [15, 14], [13, 14], [10.879, 14.879], [10, 17], [10, 19], [9.121, 21.121], [7, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
