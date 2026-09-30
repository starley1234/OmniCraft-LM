$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[26, 0], [25.522, 4.961], [24.107, 9.74], [18.544, 7.492], [17.014, 10.514], [14.996, 13.234], [12.548, 15.574], [9.74, 17.468], [6.653, 18.861], [3.375, 19.713], [0, 20], [0, 8], [2.472, 7.608], [4.702, 6.472], [6.472, 4.702], [7.608, 2.472], [8, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
