$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 19], [45.121, 21.121], [43, 22], [33, 22], [30.879, 21.121], [30, 19], [30, 15], [29.121, 12.879], [27, 12], [19, 12], [16.879, 12.879], [16, 15], [16, 19], [15.121, 21.121], [13, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
