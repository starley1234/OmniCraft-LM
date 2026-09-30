$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[25.212, 0], [24.661, 5.724], [23.027, 11.238], [19.318, 9.74], [17.983, 12.548], [16.322, 15.177], [14.359, 17.589], [12.122, 19.749], [9.643, 21.627], [6.958, 23.196], [4.104, 24.432], [0, 13.156], [3.04, 11.607], [5.616, 9.368], [7.573, 6.573], [8.796, 3.387], [9.212, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
