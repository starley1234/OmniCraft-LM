$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 37], [39.121, 39.121], [37, 40], [29, 40], [26.879, 39.121], [26, 37], [26, 15], [25.121, 12.879], [23, 12], [17, 12], [14.879, 12.879], [14, 15], [14, 37], [13.121, 39.121], [11, 40], [3, 40], [0.879, 39.121], [0, 37]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
