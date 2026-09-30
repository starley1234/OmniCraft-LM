$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [25, 0], [27.121, 0.879], [28, 3], [28, 19], [27.121, 21.121], [25, 22], [21, 22], [18.879, 21.121], [18, 19], [18, 15], [17.121, 12.879], [15, 12], [13, 12], [10.879, 12.879], [10, 15], [10, 19], [9.121, 21.121], [7, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
