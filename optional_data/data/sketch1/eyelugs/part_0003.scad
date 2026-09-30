$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 31], [39.121, 33.121], [37, 34], [28, 34], [25.879, 33.121], [25, 31], [25, 13], [24.121, 10.879], [22, 10], [18, 10], [15.879, 10.879], [15, 13], [15, 31], [14.121, 33.121], [12, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
