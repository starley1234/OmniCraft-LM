$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [31, 0], [33.121, 0.879], [34, 3], [34, 37], [33.121, 39.121], [31, 40], [27, 40], [24.879, 39.121], [24, 37], [24, 15], [23.121, 12.879], [21, 12], [13, 12], [10.879, 12.879], [10, 15], [10, 37], [9.121, 39.121], [7, 40], [3, 40], [0.879, 39.121], [0, 37]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
