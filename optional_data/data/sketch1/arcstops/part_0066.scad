$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[27.107, 0], [26.446, 6.869], [24.486, 13.486], [20.777, 11.987], [19.134, 15.444], [17.089, 18.68], [14.673, 21.648], [11.92, 24.307], [8.869, 26.618], [5.564, 28.548], [2.052, 30.07], [0, 24.432], [5.646, 21.555], [10.429, 17.397], [14.064, 12.206], [16.335, 6.29], [17.107, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
