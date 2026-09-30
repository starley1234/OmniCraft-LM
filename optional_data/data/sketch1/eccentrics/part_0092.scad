$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 19], [2.546, 9.5], [9.5, 2.546], [19, 0], [28.5, 2.546], [39.356, 9.041], [43.216, 14.554], [43.803, 21.257], [40.959, 27.356], [35.446, 31.216], [28.5, 35.454], [19, 38], [9.5, 35.454], [2.546, 28.5]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
