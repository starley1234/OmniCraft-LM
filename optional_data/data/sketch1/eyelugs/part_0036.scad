$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [25, 0], [27.121, 0.879], [28, 3], [28, 31], [27.121, 33.121], [25, 34], [21, 34], [18.879, 33.121], [18, 31], [18, 13], [17.121, 10.879], [15, 10], [13, 10], [10.879, 10.879], [10, 13], [10, 31], [9.121, 33.121], [7, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
