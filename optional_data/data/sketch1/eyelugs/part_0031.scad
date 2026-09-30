$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [37, 0], [39.121, 0.879], [40, 3], [40, 37], [39.121, 39.121], [37, 40], [30, 40], [27.879, 39.121], [27, 37], [27, 13], [26.121, 10.879], [24, 10], [16, 10], [13.879, 10.879], [13, 13], [13, 37], [12.121, 39.121], [10, 40], [3, 40], [0.879, 39.121], [0, 37]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
