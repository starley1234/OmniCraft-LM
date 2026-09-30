$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[37.739, 0], [37.272, 6.68], [35.88, 13.231], [28.19, 11.025], [26.362, 16.087], [23.871, 20.857], [20.762, 25.25], [17.092, 29.186], [12.927, 32.594], [8.342, 35.411], [3.42, 37.588], [0, 28.191], [6.515, 24.871], [12.034, 20.074], [16.228, 14.084], [18.848, 7.258], [19.739, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
