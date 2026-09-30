$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [25, 0], [27.121, 0.879], [28, 3], [28, 31], [27.121, 33.121], [25, 34], [23, 34], [20.879, 33.121], [20, 31], [20, 13], [19.121, 10.879], [17, 10], [11, 10], [8.879, 10.879], [8, 13], [8, 31], [7.121, 33.121], [5, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
