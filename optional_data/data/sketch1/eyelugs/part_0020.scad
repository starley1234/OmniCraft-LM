$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 31], [45.121, 33.121], [43, 34], [33, 34], [30.879, 33.121], [30, 31], [30, 17], [29.121, 14.879], [27, 14], [19, 14], [16.879, 14.879], [16, 17], [16, 31], [15.121, 33.121], [13, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
