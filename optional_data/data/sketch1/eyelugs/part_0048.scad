$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 19], [39.121, 21.121], [37, 22], [28, 22], [25.879, 21.121], [25, 19], [25, 13], [24.121, 10.879], [22, 10], [18, 10], [15.879, 10.879], [15, 13], [15, 19], [14.121, 21.121], [12, 22], [3, 22], [0.879, 21.121], [0, 19]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
