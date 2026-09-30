$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [31, 0], [33.121, 0.879], [34, 3], [34, 31], [33.121, 33.121], [31, 34], [27, 34], [24.879, 33.121], [24, 31], [24, 13], [23.121, 10.879], [21, 10], [13, 10], [10.879, 10.879], [10, 13], [10, 31], [9.121, 33.121], [7, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
