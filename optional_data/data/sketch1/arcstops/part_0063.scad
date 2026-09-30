$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46.945, 0], [46.594, 5.01], [45.55, 9.923], [41.705, 8.82], [38.816, 15.723], [34.402, 21.766], [28.706, 26.618], [22.039, 30.015], [14.765, 31.771], [7.283, 31.79], [0, 30.07], [3.42, 20.673], [11.712, 21.987], [19.893, 20.098], [26.77, 15.282], [31.343, 8.241], [32.945, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
