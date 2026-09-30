$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[27.212, 0], [26.261, 7.742], [23.466, 15.023], [18.168, 12.206], [16.767, 14.539], [15.129, 16.712], [13.273, 18.703], [11.219, 20.488], [8.99, 22.049], [6.609, 23.369], [4.104, 24.432], [0, 13.156], [3.04, 11.607], [5.616, 9.368], [7.573, 6.573], [8.796, 3.387], [9.212, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
