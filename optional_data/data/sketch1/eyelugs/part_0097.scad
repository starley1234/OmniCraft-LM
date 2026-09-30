$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [31, 0], [33.121, 0.879], [34, 3], [34, 31], [33.121, 33.121], [31, 34], [25, 34], [22.879, 33.121], [22, 31], [22, 17], [21.121, 14.879], [19, 14], [15, 14], [12.879, 14.879], [12, 17], [12, 31], [11.121, 33.121], [9, 34], [3, 34], [0.879, 33.121], [0, 31]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
