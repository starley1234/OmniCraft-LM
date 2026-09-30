$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [31, 0], [33.121, 0.879], [34, 3], [34, 25], [33.121, 27.121], [31, 28], [27, 28], [24.879, 27.121], [24, 25], [24, 11], [23.121, 8.879], [21, 8], [13, 8], [10.879, 8.879], [10, 11], [10, 25], [9.121, 27.121], [7, 28], [3, 28], [0.879, 27.121], [0, 25]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
