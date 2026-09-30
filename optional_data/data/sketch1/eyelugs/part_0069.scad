$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 31], [39.121, 33.121], [37, 34], [30, 34], [27.879, 33.121], [27, 31], [27, 17], [26.121, 14.879], [24, 14], [16, 14], [13.879, 14.879], [13, 17], [13, 31], [12.121, 33.121], [10, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
