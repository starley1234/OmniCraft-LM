$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [43, 0], [45.121, 0.879], [46, 3], [46, 37], [45.121, 39.121], [43, 40], [34, 40], [31.879, 39.121], [31, 37], [31, 11], [30.121, 8.879], [28, 8], [18, 8], [15.879, 8.879], [15, 11], [15, 37], [14.121, 39.121], [12, 40], [3, 40], [0.879, 39.121], [0, 37]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
