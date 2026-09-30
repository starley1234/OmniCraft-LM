$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 25], [39.121, 27.121], [37, 28], [30, 28], [27.879, 27.121], [27, 25], [27, 15], [26.121, 12.879], [24, 12], [16, 12], [13.879, 12.879], [13, 15], [13, 25], [12.121, 27.121], [10, 28], [3, 28], [0.879, 27.121], [0, 25]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
