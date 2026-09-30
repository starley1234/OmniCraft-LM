$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 31], [39.121, 33.121], [37, 34], [29, 34], [26.879, 33.121], [26, 31], [26, 17], [25.121, 14.879], [23, 14], [17, 14], [14.879, 14.879], [14, 17], [14, 31], [13.121, 33.121], [11, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
