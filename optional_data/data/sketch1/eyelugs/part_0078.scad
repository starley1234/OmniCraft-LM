$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 31], [45.121, 33.121], [43, 34], [30, 34], [27.879, 33.121], [27, 31], [27, 11], [26.121, 8.879], [24, 8], [22, 8], [19.879, 8.879], [19, 11], [19, 31], [18.121, 33.121], [16, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
